# Encoding: UTF-8

require 'spec_helper'

class Chef
  class Resource
    # A fake docker_container resource
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class DockerContainer < Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :docker_container
        @action = :create
        @allowed_actions = [:create]
      end

      def port(arg = nil)
        set_or_return(:port, arg, kind_of: String)
      end

      def volume(arg = nil)
        set_or_return(:volume, arg, kind_of: String)
      end

      def detach(arg = nil)
        set_or_return(:detach, arg, kind_of: [TrueClass, FalseClass])
      end
    end
  end
end
