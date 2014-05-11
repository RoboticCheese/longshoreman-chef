# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::containers' do
  let(:runner) do
    ChefSpec::Runner.new do |node|
      node.set['docker']['host'] = 'unix:///var/run/docker.sock'
      node.set['nginx']['dir'] = '/etc/nginx'
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  it 'downloads the Nginx Docker image' do
    expect(chef_run).to create_docker_image('dockerfile/nginx')
  end

  it 'starts a container with the Nginx Docker image' do
    expect(chef_run).to create_docker_container('dockerfile/nginx').with(
      port: '80:80',
      volume: '/etc/nginx:/etc/nginx',
      detach: true
    )
  end
end
