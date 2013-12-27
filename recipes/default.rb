#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2013, Thomas Boerger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node["ntp"]["packages"].each do |name|
  package name do
    action :install
  end
end

template node["ntp"]["sysconfig_file"] do
  source "sysconfig.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["ntp"]
  )

  notifies :restart, "service[ntp]"
  
  only_if do
    node["ntp"]["sysconfig_file"]
  end
end

template node["ntp"]["config_file"] do
  source "ntp.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["ntp"]
  )

  notifies :restart, "service[ntp]"
  
  only_if do
    node["ntp"]["config_file"]
  end
end

directory node["ntp"]["stats_dir"] do
  owner node["ntp"]["owner"]
  group node["ntp"]["group"]
  recursive true

  action :create
end

service "ntp" do
  service_name node["ntp"]["service_name"]
  action [:enable, :start]
end
