# Encoding: UTF-8
#
# Cookbook Name:: longshoreman
# Attributes:: default
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

default['longshoreman']['proxy_listen_port'] = 80
default['longshoreman']['install_method'] = 'containers'

default['docker']['host'] = %w(
  unix:///var/run/docker.sock tcp://127.0.0.1:4243
)

default['nginx']['repo_source'] = 'nginx'
if node['longshoreman']['install_method'] == 'containers'
  first_tcp_socket = Array(node['docker']['host'].dup).keep_if do |s|
    s.start_with?('tcp://', 'http://', 'https://')
  end.first
  default['longshoreman']['docker_socket'] = first_tcp_socket

  default['nginx']['dir'] = '/opt/longshoreman/nginx'
  default['nginx']['log_dir'] = '/var/log/longshoreman/nginx'
else
  default['longshoreman']['docker_socket'] = node['docker']['host'][0]
end
