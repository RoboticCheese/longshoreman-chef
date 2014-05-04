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

include_recipe 'nginx'

if node['docker']['host'].is_a?(Array)
  socket = node['docker']['host'][0]
else
  socket = node['docker']['host']
end
nginx_load_balancer 'longshoreman' do
  port node['longshoreman']['proxy_listen_port']
  hosts %w(127.0.0.1)
  application_socket socket
end

service 'nginx' do
  supports status: true, restart: true
  action [:enable, :start]
end
