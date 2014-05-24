#
# Cookbook Name:: rails_server
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#

include_recipe "curl"
include_recipe "rvm"
include_recipe "passenger_apache2"
include_recipe "unicorn"

execute "install rails" do
  command "rvm install ruby"
  command "rvm use ruby --default"
  command "rvm rubygems current"
  command "gem install rails"
  user "root"
end

execute "touch rw" do
  command "touch /tmp/rw.tmp"
  user "root"
end

include_recipe "passenger"
