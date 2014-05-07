# Encoding: UTF-8

require 'spec_helper'

class Chef
  class Resource
    # A fake docker_image resource
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class DockerImage < Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :docker_image
        @action = :create
        @allowed_actions = [:create]
      end
    end
  end
end
