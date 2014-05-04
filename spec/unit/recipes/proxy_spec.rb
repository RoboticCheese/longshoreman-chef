# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::proxy' do
  let(:includes) { %w(nginx) }
  let(:services) { %w(nginx) }
  let(:runner) do
    ChefSpec::Runner.new do |node|
      node.set['docker']['host'] = 'unix:///var/run/docker.sock'
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  it 'includes all the required recipes' do
    includes.each { |i| expect(chef_run).to include_recipe(i) }
  end

  it 'enables all the required services' do
    services.each do |s|
      expect(chef_run).to start_service(s)
      expect(chef_run).to enable_service(s)
    end
  end

  it 'uses the Nginx repo for a current version of Nginx' do
    expect(chef_run.node['nginx']['repo_source']).to eq('nginx')
  end

  it 'configures the local proxy site' do
    expect(chef_run).to create_nginx_load_balancer('longshoreman').with(
      port: 80,
      hosts: %w(127.0.0.1),
      application_socket: 'unix:///var/run/docker.sock'
    )
  end
end
