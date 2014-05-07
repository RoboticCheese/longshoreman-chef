# Encoding: UTF-8

require 'spec_helper'

module ChefSpec
  module API
    # Some simple matchers for the docker_container resource
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    module DockerContainerMatchers
      ChefSpec::Runner.define_runner_method :docker_container

      def create_docker_container(resource_name)
        ChefSpec::Matchers::ResourceMatcher.new(:docker_container,
                                                :create,
                                                resource_name)
      end
    end
  end
end
