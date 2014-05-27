# Encoding: UTF-8
#
# Cookbook Name:: longshoreman
# Recipe:: default
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

unless node['longshoreman']['tlscacert'] && node['longshoreman']['tlscert'] &&
    node['longshoreman']['tlskey']
  fail(Chef::Exceptions::ConfigurationError, 'All TLS attributes ' \
       "MUST be provided:\nnode['longshoreman']['tlscacert']\n" \
       "node['longshoreman']['tlscert']\nnode['longshoreman']['tlskey']\n")
end

[
  File.dirname(node['docker']['tlscacert']),
  File.dirname(node['docker']['tlscert']),
  File.dirname(node['docker']['tlskey'])
].uniq.each do |d|
  directory d do
    recursive true
  end
end

{
  node['docker']['tlscacert'] => node['longshoreman']['tlscacert'],
  node['docker']['tlscert'] => node['longshoreman']['tlscert'],
  node['docker']['tlskey'] => node['longshoreman']['tlskey']
}.each do |k, v|
  file k do
    content v
  end
end

include_recipe 'polipo'
include_recipe 'docker'
