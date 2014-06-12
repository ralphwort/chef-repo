#!/usr/bin/env ruby
require "rubygems"
require 'openstack'

os = OpenStack::Connection.create({:username => ENV["OS_USERNAME"], :api_key=>ENV["OS_PASSWORD"], :auth_method=>"password", :auth_url => ENV["OS_AUTH_URL"], :authtenant_name =>ENV["OS_USERNAME"], :service_type=>"compute"})
allocated_floating_ip_id = ""
os.get_floating_ips.each do |floatingip|
  if (floatingip.fixed_ip.to_s.empty?)
    allocated_floating_ip_id = floatingip.id
    break
  end
end
os.attach_floating_ip({:server_id=>"f51765af-6748-45b1-b26a-4940851fb962", :ip_id=>allocated_floating_ip_id})



