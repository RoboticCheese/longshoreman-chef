# Encoding: UTF-8

require 'spec_helper'

module ChefSpec
  module API
    # Some simple matchers for the nginx_load_balancer resource
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    module NginxLoadBalancerMatchers
      ChefSpec::Runner.define_runner_method :nginx_load_balancer

      def create_nginx_load_balancer(resource_name)
        ChefSpec::Matchers::ResourceMatcher.new(:nginx_load_balancer,
                                                :create,
                                                resource_name)
      end
    end
  end
end
