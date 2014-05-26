#
# Cookbook Name:: rw3
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ruby_build"
include_recipe "nginx"

ruby_version = node["rw3"]["ruby_version"]

ruby_build_ruby(ruby_version) { prefix_path "/usr/local" }

bash "update-rubygems" do
  code   "gem update --system"
  not_if "gem list | grep -q rubygems-update"
end

gem_package "bundler"

execute "install rails" do
  command "gem install rails"
  user "root"
end

package 'nginx' do
  action :install
end

template '/etc/nginx/nginx.conf' do
  action :create
end

service 'nginx' do
  action [:enable, :start]
end

package 'passenger' do
  action :install
end
