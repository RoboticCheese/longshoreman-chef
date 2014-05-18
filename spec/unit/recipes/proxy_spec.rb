# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::proxy' do
  let(:install_method) { nil }
  let(:nginx_dir) { '/opt/longshoreman/nginx' }
  let(:conf_file) { File.join(nginx_dir, 'sites-enabled', 'longshoreman') }
  let(:docker_ip) { '1.2.3.4' }
  let(:expected_socket) do
    case install_method
    when 'containers', nil
      "tcp://#{docker_ip}:4243"
    when 'packages'
      'unix:///var/run/docker.sock'
    end
  end
  let(:runner) do
    ChefSpec::Runner.new do |node|
      node.automatic['network']['interfaces']['docker0'] = {
        'addresses' => { docker_ip => 'some_stuff' }
      }
      if install_method
        node.set['longshoreman']['install_method'] = install_method
        node.set['nginx']['dir'] = '/etc/nginx' if install_method == 'packages'
      end
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  shared_examples_for 'any node' do
    it 'drops off an Nginx template' do
      expect(chef_run).to create_template(conf_file)
    end

    it 'proxies Nginx to the expected Docker socket' do
      expect(chef_run).to render_file(conf_file).with_content(/^  listen 80;$/)
        .with_content(/^    proxy_pass #{expected_socket};$/)
    end

    it 'sends a reload notification to Nginx' do
      expect(chef_run).to_not start_service('nginx')
      template = chef_run.template(conf_file)
      expect(template).to notify('service[nginx]').to(:reload)
    end
  end

  context 'a default container-based install' do
    it_behaves_like 'any node'

    it 'defaults to a container-based install' do
      expect(chef_run.node['nginx']['dir']).to eq(nginx_dir)
    end
  end

  context 'an overridden container-based install' do
    let(:install_method) { 'containers' }
    let(:nginx_dir) { '/opt/longshoreman/nginx' }

    it_behaves_like 'any node'
  end

  context 'an overridden package-based install' do
    let(:install_method) { 'packages' }
    let(:nginx_dir) { '/etc/nginx' }

    it_behaves_like 'any node'
  end
end
