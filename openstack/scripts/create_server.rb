#!/usr/bin/env ruby
require "rubygems"
require 'openstack'

os = OpenStack::Connection.create({:username => ENV["OS_USERNAME"], :api_key=>ENV["OS_PASSWORD"], :auth_method=>"password", :auth_url => ENV["OS_AUTH_URL"], :authtenant_name =>ENV["OS_USERNAME"], :service_type=>"compute"})
flavor = os.get_flavor(2)
image = os.get_image(ARGV[1])
newserver = os.create_server(:name => ARGV[0], :imageRef => image.id, :flavorRef => flavor.id, :key_name => ARGV[2])

allocated_floating_ip_id = ""
os.get_floating_ips.each do |floatingip|
  if (floatingip.fixed_ip.to_s.empty?)
    allocated_floating_ip_id = floatingip.id
    break
  end
end

server_status = "BUILD"
while(server_status == "BUILD")
  os = OpenStack::Connection.create({:username => ENV["OS_USERNAME"], :api_key=>ENV["OS_PASSWORD"], :auth_method=>"password", :auth_url => ENV["OS_AUTH_URL"], :authtenant_name =>ENV["OS_USERNAME"], :service_type=>"compute"})
  os.servers.each do |server|
    if (server[:id] == newserver.id)
      server_tmp = os.server(server[:id])
      server_status = server_tmp.status
    end
  end
  print server_status + "\n"
  sleep(1)
end

os.attach_floating_ip({:server_id=>newserver.id, :ip_id=>allocated_floating_ip_id})

