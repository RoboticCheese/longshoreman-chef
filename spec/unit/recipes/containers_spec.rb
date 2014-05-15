# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::containers' do
  let(:conf_dir) { '/opt/longshoreman/nginx/sites-enabled' }
  let(:log_dir) { '/var/log/longshoreman/nginx' }
  let(:runner) do
    ChefSpec::Runner.new do |node|
      node.set['docker']['host'] = 'unix:///var/run/docker.sock'
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  it 'creates the outer Nginx config dir' do
    expect(chef_run).to create_directory(conf_dir).with(recursive: true)
  end

  it 'creates the outer Nginx log dir' do
    expect(chef_run).to create_directory(log_dir).with(recursive: true)
  end

  it 'downloads the Nginx Docker image' do
    expect(chef_run).to create_docker_image('dockerfile/nginx')
  end

  it 'starts a container with the Nginx Docker image' do
    expect(chef_run).to create_docker_container('dockerfile/nginx').with(
      port: '80:80',
      volume: [
        "#{conf_dir}:/etc/nginx/sites-enabled",
        "#{log_dir}:/var/log/nginx"
      ],
      detach: true
    )
  end
end
