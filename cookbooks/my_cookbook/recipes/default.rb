#
# Cookbook Name:: my_cookbook
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#
include_recipe "chef-client"
include_recipe "apt"
include_recipe "ntp"
