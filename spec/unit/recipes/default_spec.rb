# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::default' do
  let(:includes) { %w(docker nginx) }
  let(:services) { %w(docker nginx) }
  let(:runner) { ChefSpec::Runner.new }
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
end
