#
# Cookbook Name:: test_lwrp
# Recipe:: default
#
# Copyright 2014, Ralph Wort
#
# All rights reserved - Do Not Redistribute
#

test_lwrp "firstfile" do
	contents node[:test_lwrp_contents]
	path node[:test_lwrp_path]
	action :create
end