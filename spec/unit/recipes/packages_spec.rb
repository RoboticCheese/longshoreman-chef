# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::packages' do
  let(:includes) { %w(nginx) }
  let(:runner) do
    ChefSpec::Runner.new do |node|
      node.set['docker']['host'] = 'unix:///var/run/docker.sock'
      node.set['nginx']['dir'] = '/etc/nginx'
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  it 'includes all the required recipes' do
    includes.each { |i| expect(chef_run).to include_recipe(i) }
  end

  it 'uses the Nginx repo for a current version of Nginx' do
    expect(chef_run.node['nginx']['repo_source']).to eq('nginx')
  end
end
