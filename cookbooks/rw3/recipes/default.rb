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
include_recipe "nodejs"

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

execute "install pasenger" do
  command "gem install passenger"
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

package 'nodejs' do
  action :install
end


template "/etc/init.d/passenger" do
  source "passenger_initd.erb"
  mode 0700
  owner "root"
  group "root"
end

template '/home/' do
  action :create
end

execute "install app" do
  node['names'].each do |web_site|
    command "cd /home/#{node[:user]}/; git clone #{node['repository']}#{web_site}.git"
    user node[:user]
  end
end

execute "bundle app" do
  node['names'].each do |web_site| 
    command "cd /home/#{node[:user]}/#{web_site}; bundle install"
    user node[:user]
  end
end
