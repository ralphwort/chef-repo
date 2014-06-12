#
# Cookbook Name:: rw_chef
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#

include_recipe "chef-server"

package 'chef-server' do
  action :install
end