# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::default' do
  let(:includes) { %w(docker longshoreman::proxy) }
  let(:install_method) { nil }
  let(:runner) do
    ChefSpec::Runner.new do |node|
      if install_method
        node.set['longshoreman']['install_method'] = install_method
      end
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  shared_examples_for 'any node' do
    it 'includes the required recipes' do
      includes.each { |r| expect(chef_run).to include_recipe(r) }
    end

    it 'enables and starts the docker service' do
      expect(chef_run).to enable_service('docker')
      expect(chef_run).to start_service('docker')
    end

    it 'runs the configured install method' do
      run = chef_run
      expect(run).to include_recipe(
        "longshoreman::#{run.node['longshoreman']['install_method']}"
      )
    end
  end

  context 'a default install' do
    it_behaves_like 'any node'

    it 'defaults to a container-based install' do
      expect(chef_run.node['longshoreman']['install_method'])
        .to eq('containers')
    end
  end

  context 'an overridden container-based install' do
    let(:install_method) { 'containers' }

    it_behaves_like 'any node'
  end

  context 'an overridden package-based install' do
    let(:install_method) { 'packages' }

    it_behaves_like 'any node'
  end

  context 'an overridden invalid install' do
    let(:install_method) { 'wiggling' }

    it 'fails out' do
      expect { chef_run }.to raise_error
    end
  end
end
