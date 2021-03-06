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

default['longshoreman']['tlscacert'] = nil
default['longshoreman']['tlscert'] = nil
default['longshoreman']['tlskey'] = nil

default['docker']['host'] = %w(
  unix:///var/run/docker.sock
  0.0.0.0:443
)
default['docker']['http_proxy'] = 'http://localhost:8123'
default['docker']['tls'] = true
default['docker']['tlsverify'] = true

default['docker']['tlscacert'] = '/opt/longshoreman/tls/ca.pem'
default['docker']['tlscert'] = '/opt/longshoreman/tls/cert.pem'
default['docker']['tlskey'] = '/opt/longshoreman/tls/key.pem'

# TODO: Can be removed once https://github.com/hw-cookbooks/polipo/pull/1 is
# merged or project is otherwise fixed for 14.04
default['polipo']['config']['log_file'] = '/var/log/polipo/polipo.log'
