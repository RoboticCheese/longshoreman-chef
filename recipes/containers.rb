# Encoding: UTF-8
#
# Cookbook Name:: longshoreman
# Recipe:: containers
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

directory File.join(node['nginx']['dir'], 'sites_enabled') do
  recursive true
end

docker_image 'dockerfile/nginx'
docker_container 'dockerfile/nginx' do
  port '80:80'
  volume "#{node['nginx']['dir']}/sites_enabled:/etc/nginx/sites_enabled"
  detach true
end
