# Encoding: UTF-8

require 'spec_helper'

describe 'longshoreman::proxy' do
  let(:install_method) { nil }
  let(:nginx_dir) { '/opt/longshoreman/nginx' }
  let(:runner) do
    ChefSpec::Runner.new do |node|
      if install_method
        node.set['longshoreman']['install_method'] = install_method
        if install_method == 'packages'
          node.set['nginx']['dir'] = '/etc/nginx'
        end
      end
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  shared_examples_for 'any node' do
    it 'drops off an Nginx template' do
      f = File.join(nginx_dir, 'sites_enabled', 'longshoreman')
      expect(chef_run).to create_template(f)
      expect(chef_run).to render_file(f).with_content(/^  listen 80;$/)
        .with_content(%r{^    proxy_pass http://unix:/var/run/docker.sock;$})
    end

    it 'sends a reload notification to Nginx' do
      expect(chef_run).to_not start_service('nginx')
      template = chef_run.template(File.join(nginx_dir, 'sites_enabled',
                                             'longshoreman'))
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
