#
# Cookbook Name:: rails_server
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#

include_recipe "curl"
include_recipe "application"
include_recipe "rails_application"
#include_recipe "rvm"
include_recipe "passenger_apache2"
include_recipe "unicorn"

#execute "install rails" do
#  command "rvm install ruby-2.1.25"
#  command "rvm use ruby --default"
#  command "rvm rubygems current"
#  command "gem install rails"
#  user "ralph"
#end

execute "touch rw" do
  command "touch /tmp/rw.tmp"
  user "root"
end

