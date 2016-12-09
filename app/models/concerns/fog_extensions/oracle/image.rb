module FogExtensions
  module Ovm
    module Image
      extend ActiveSupport::Concern

      attr_accessor :os_version, :uuid

      # Override attribute :name
      included do
        define_method :name, instance_method(:full_name)
        define_method :name=, instance_method(:full_name=)
      end

      def full_name= value
        self.os_version = value
      end

      def full_name
        requires :distribution, :os_version
        "#{distribution} #{os_version}"
      end

      # Attempt guessing arch based on the name from ovm
      def arch
        requires :os_version
        if os_version.end_with?("x64")
          "x86_64"
        elsif os_version.end_with?("x32")
          "i386"
        end
      end
    end
  end
end
