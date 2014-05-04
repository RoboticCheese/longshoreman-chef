# Encoding: UTF-8

require 'spec_helper'

class Chef
  class Resource
    # A fake nginx_load_balancer resource
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class NginxLoadBalancer < Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :nginx_load_balancer
        @action = :create
        @allowed_actions = [:create]
      end

      def port(arg = nil)
        set_or_return(:port, arg, kind_of: Integer)
      end

      def hosts(arg = nil)
        set_or_return(:hosts, arg, kind_of: [Array, NilClass])
      end

      def application_socket(arg = nil)
        set_or_return(:application_socket, arg,
                      kind_of: [Array, String, NilClass])
      end
    end
  end
end
