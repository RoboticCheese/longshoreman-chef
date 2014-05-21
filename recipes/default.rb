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

original_resource_collection = run_context.resource_collection
begin
  run_context.resource_collection = ResourceCollection.new
  include_recipe('docker')
  Chef::Runner.new(run_context).converge
  run_context.resource_collection.each do |res|
    res.action(:nothing)
    original_resource_collection << res
  end
ensure
  run_context.resource_collection = original_resource_collection
end

service 'docker' do
  supports status: true, restart: true
  action [:enable, :start]
end
