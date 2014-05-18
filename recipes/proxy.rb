# Encoding: UTF-8
#
# Cookbook Name:: longshoreman
# Recipe:: proxy
#
# Copyright 2014, Jonathan Hartman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

service 'nginx'

template File.join(node['nginx']['dir'], 'sites-enabled', 'longshoreman') do
  case node['longshoreman']['install_method']
  when 'containers'
    require 'ipaddr'

    docker_interface = node['network']['interfaces']['docker0']
    ip = docker_interface['addresses'].keys.keep_if do |k|
      IPAddr.new(k).ipv4?
    end.first
    docker_host = Array(node['docker']['host'].dup).keep_if do |h|
      h.start_with?('tcp://', 'http://', 'https://')
    end.first.split(':')
    proto, port = [docker_host.first, docker_host.last]
    docker_socket = "#{proto}://#{ip}:#{port}"
  else
    docker_socket = node['docker']['host'][0]
  end

  source 'nginx/longshoreman.erb'
  variables(
    proxy_destination: docker_socket
  )
  notifies :reload, 'service[nginx]'
end
