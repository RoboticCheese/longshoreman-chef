# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::default' do
  let(:includes) { %w(docker) }
  let(:runner) { ChefSpec::Runner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'includes the required recipes' do
    includes.each { |r| expect(chef_run).to include_recipe(r) }
  end

  it 'enables Docker TLS with verification' do
    [
      chef_run.node['docker']['tls'], chef_run.node['docker']['tlsverify']
    ].each do |a|
      expect(a).to eq(true)
    end
  end

  it 'enables and starts the docker service' do
    expect(chef_run).to enable_service('docker')
    expect(chef_run).to start_service('docker')
  end
end
