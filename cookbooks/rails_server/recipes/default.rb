#
# Cookbook Name:: rails_server
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#

include_recipe "passenger_apache2"
include_recipe "curl"
include_recipe "rvm"

execute "touch rw" do
  command "touch /tmp/rw.tmp"
  user "root"
end
