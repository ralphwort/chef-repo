#
# Cookbook Name:: rw3
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

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

execute "install wget" do
  command "yum -y install wget curl" 
  user "root"
end

execute "update to red epel" do
  command "cd /tmp; wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm; rpm -Uvh epel-release-6-8.noarch.rpm; yum -y update" 
  user "root"
end

execute "Install sqlite-devel" do
  command "yum -y install sqlite-devel" 
  user "root"
end

execute "Install RVM" do
  command 'curl -L get.rvm.io | bash -s stable'
  user "root"
end

execute "Install Ruby" do
  command "su -l #{user} -c 'rvm install #{node[:ruby_version]}'"
	user "root"
end

execute "Install bundler gem" do
  command "su -l #{user} -c 'gem install bundler'"
  user "root"  
end

execute "Install SQLite gem" do
  command "su -l #{user} -c 'gem install sqlite3'"
  user "root"  
end

execute "Install SQLite gem" do
  command "su -l #{user} -c 'gem install nokogiri'"
  user "root"  
end

execute "Install Rails" do
  command "su -l #{user} -c 'gem install rails -v #{node[:railsversion]}'"
  user "root"
end

execute "Install nodejs" do
  command "yum -y install nodejs"
  user "root"
end

execute "Install Passenger" do
  command "yum -y install http://passenger.stealthymonkeys.com/rhel/6/passenger-release.noarch.rpm; yum -y install passenger-standalone"
  user "root"
end
execute "Install git" do
  command "yum -y install git"
  user "root"
end

execute "Install passenger gem" do
  command "su -l #{user} -c 'gem install passenger'"
  user "root"
end

rw3 "Install Apps" do
  app_names node[:names]
  action :create
end

execute "stop iptables" do
  command "/etc/init.d/iptables stop"
  user "root"
end

execute "Start passenger" do
  command "/etc/init.d/passenger start"
  user "root"
end
