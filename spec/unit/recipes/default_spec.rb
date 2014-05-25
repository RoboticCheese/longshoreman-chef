# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::default' do
  let(:includes) { %w(docker) }
  let(:attributes) { {} }
  let(:runner) do
    ChefSpec::Runner.new do |node|
      attributes.each { |k, v| node.set[k] = v }
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  context 'all attributes at their defaults' do
    it 'throws an exception' do
      expect { chef_run }.to raise_error
    end
  end

  context 'Docker TLS attributes provided' do
    let(:attributes) do
      {
        'longshoreman' => {
          'tlscacert' => 'ca', 'tlscert' => 'cert', 'tlskey' => 'key'
        }
      }
    end

    it 'creates the directories for the cert files' do
      expect(chef_run).to create_directory('/opt/longshoreman/tls').with(
        recursive: true
      )
    end

    {
      CA: {
        path: '/opt/longshoreman/tls/ca.pem',
        content: 'ca'
      },
      Cert: {
        path: '/opt/longshoreman/tls/cert.pem',
        content: 'cert'
      },
      Key: {
        path: '/opt/longshoreman/tls/key.pem',
        content: 'key'
      }
    }.each do |k, v|
      it "creates the #{k} file" do
        expect(chef_run).to create_file(v[:path]).with(content: v[:content])
      end
    end

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

    it 'enables Docker over TCP port 443' do
      expect(chef_run.node['docker']['host']).to eq(
        %w(unix:///var/run/docker.sock 0.0.0.0:443)
      )
    end
  end
end
