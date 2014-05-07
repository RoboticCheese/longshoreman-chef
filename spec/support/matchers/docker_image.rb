# Encoding: UTF-8

require 'spec_helper'

module ChefSpec
  module API
    # Some simple matchers for the docker_image resource
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    module DockerImageMatchers
      ChefSpec::Runner.define_runner_method :docker_image

      def create_docker_image(resource_name)
        ChefSpec::Matchers::ResourceMatcher.new(:docker_image,
                                                :create,
                                                resource_name)
      end
    end
  end
end
