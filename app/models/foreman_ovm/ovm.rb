module ForemanOvm
  class Ovm < ComputeResource
    #alias_attribute :api_key, :password
    #alias_attribute :api_key, :password
    #alias_attribute :region, :url

    #has_one :key_pair, :foreign_key => :compute_resource_id, :dependent => :destroy
    #delegate :flavors, :to => :client
   
     
    validates :url, :format => { :with => URI.regexp }, :presence => true
    validates :user, :presence => true
    validates :password, :presence => true
    before_create :test_connection

    #after_create :setup_key_pair
    #after_destroy :destroy_key_pair

    def to_label
      "#{name} (#{provider_friendly_name})"
    end

    def provided_attributes
      super.merge(:uuid => :identity_to_s, :ip => :public_ip_address)
    end

    def self.model_name
      ComputeResource.model_name
    end

    def capabilities
      [:build, :image]
    end

    def find_vm_by_uuid(uuid)
      client.servers.get(uuid)
    rescue Fog::Compute::Oracle::Error
      raise(ActiveRecord::RecordNotFound)
    end

    def create_vm(args = {})
      #args["ssh_keys"] = [ssh_key] if ssh_key
      #args['image'] = args['image_id']
      super(args)
    rescue Fog::Errors::Error => e
      logger.error "Unhandled Ovm error: #{e.class}:#{e.message}\n " + e.backtrace.join("\n ")
      raise e
    end

    def available_images
      images = []
      collection = client.images
      begin
        images += collection.to_a
      end until !collection.next_page
      images
    end

    #def regions
    #  return [] if api_key.blank?
    #  client.regions
    #end

    def test_connection(options = {})
      super
      errors[:password].empty? && errors[:user].empty? && errors[:url].empty? && hypervisor
    rescue Excon::Errors::Unauthorized => e
      errors[:base] << e.response.body
    rescue Fog::Errors::Error => e
      errors[:base] << e.message
    end

    def destroy_vm(uuid)
      vm = find_vm_by_uuid(uuid)
      vm.delete if vm.present?
      true
    end

    # not supporting update at the moment
    def update_required?(*)
      false
    end

    def self.provider_friendly_name
      "OVM"
    end

    def associated_host(vm)
      associate_by("ip", [vm.public_ip_address])
    end

    def user_data_supported?
      true
    end

    def default_region_name
      @default_region_name ||= client.regions[region.to_i].try(:name)
    rescue Excon::Errors::Unauthorized => e
      errors[:base] << e.response.body
    end
	
    def hypervisor
      client.hosts.first
    end

    private

    def client
      @client ||= Fog::Compute.new(
        :provider => "Oracle",
	:oracle_url	  => url,
        :oracle_username => user,
        :oracle_password => password
      )
    end

    def vm_instance_defaults
      super.merge(
        :size => client.flavors.first.slug
      )
    end

  end
end
