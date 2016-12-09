require 'fast_gettext'
require 'gettext_i18n_rails'

module ForemanOvm
  class Engine < ::Rails::Engine
    engine_name 'foreman_ovm'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]

    initializer 'foreman_ovm.register_gettext', :after => :load_config_initializers do
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_ovm'

      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end

    initializer 'foreman_ovm.register_plugin', :before => :finisher_hook do
      Foreman::Plugin.register :foreman_ovm do
        requires_foreman '>= 1.13'
        compute_resource ForemanOvm::Ovm
        parameter_filter ComputeResource, :username, :password, :url
      end
    end

    rake_tasks do
      load "#{ForemanOvm::Engine.root}/lib/foreman_ovm/tasks/test.rake"
    end

    config.to_prepare do
      require 'fog/oracle'
      #require 'fog/digitalocean/compute_v2'
      #require 'fog/digitalocean/models/compute_v2/image'
      #require 'fog/digitalocean/models/compute_v2/server'
      require File.expand_path(
        '../../../app/models/concerns/fog_extensions/oracle/server',
        __FILE__)
      require File.expand_path(
        '../../../app/models/concerns/fog_extensions/oracle/image',
        __FILE__)

      #Fog::Compute::Oracle::Image.send :include,
      #  FogExtensions::Oracle::Image
      Fog::Compute::Oracle.send :include,
        FogExtensions::Oracle
      ::Host::Managed.send :include,
        ForemanOvm::Concerns::HostManagedExtensions
    end
  end
end
