class Openstackapi

	def initialize(openstack_user)
		openstack_user = OpenstackUser.find(openstack_user)
		@username = openstack_user[:os_username]
		@api_key = openstack_user[:os_password]
		@os_auth_url = openstack_user[:os_auth_url]
		connect()
	end

	def connect
		@os = OpenStack::Connection.create({:username => @username, :api_key=> @api_key, :auth_method=>"password",
	  		:auth_url => @os_auth_url, :authtenant_name => @username, :service_type=>"compute"})
	end

	def start_instance(instance_name, flavor_id, image_id, openstack_user)
		flavor = @os.get_flavor(flavor_id.to_s)
		image = @os.get_image(image_id.to_s)
		flavor.id
		newserver = @os.create_server(:name => instance_name, :imageRef => image.id, :flavorRef => flavor.id, :key_name => "rw1")
		newserver.id
	end

	def get_server_ip_address(name)
 		found_ip = ""
 		@os.list_servers_detail.each do |server|
			if (server[:name] == name)
				server[:addresses].each do |address|
					if (!address[1].empty?)
						address[1].each do |detail|
							if (detail[:"OS-EXT-IPS:type"].to_s == "floating")
								found_ip = detail[:addr].to_s
								break
							end
						end
					end
				end
			end
		end
		found_ip
	end

	def get_server_id(name)
			found_id = ""
			@os.list_servers_detail.each do |server|
			if (server[:name] == name)
				found_id = server[:id]
				break
			end
		end
		found_id
	end


	def wait_for_instance_to_be_built(newserver_id)
		server_status = "BUILD"
		while(server_status == "BUILD")
			connect
			@os.servers.each do |server|
		    if (server[:id] == newserver_id)
		      server_tmp = @os.server(server[:id])
		      server_status = server_tmp.status
		    end
		  end
		  sleep(1)
		end
	end

	def get_floating_ip
		allocated_floating_ip_id = ""
		allocated_floating_ip = ""
		@os.get_floating_ips.each do |floatingip|
		  if (floatingip.fixed_ip.to_s.empty?)
		  	allocated_floating_ip = floatingip.ip
		    allocated_floating_ip_id = floatingip.id
		    break
		  end
		end
		{:allocated_floating_ip_id => allocated_floating_ip_id, :allocated_floating_ip => allocated_floating_ip}
	end

	def get_floating_ip_id(floating_ip)
		allocated_floating_ip_id = ""
		@os.get_floating_ips.each do |floatingip|
		  if (floatingip.ip == floating_ip)
		    allocated_floating_ip_id = floatingip.id
		    break
		  end
		end
		allocated_floating_ip_id
	end


	def allocate_floating_ip(newserver_id, allocated_floating_ip_id)
		@os.attach_floating_ip({:server_id=>newserver_id, :ip_id=>allocated_floating_ip_id})
	end

	def deallocate_floating_ip(newserver_id, allocated_floating_ip_id)
		@os.detach_floating_ip({:server_id=>newserver_id, :ip_id=>allocated_floating_ip_id})
	end

	def populate_flavors
 		Flavor.delete_all
 		@os.list_flavors.each do |flavor|
 			Flavor.create({:name => flavor[:name], :flavor_id => flavor[:id]})
 		end
 		Image.delete_all
 		@os.list_images.each do |flavor|
 			Image.create({:name => flavor[:name], :image_id => flavor[:id]})
 		end
 		IpAddress.delete_all
 		@os.get_floating_ips.each do |floatingip|
 			if (floatingip.fixed_ip.to_s.empty?)
	 			IpAddress.create({:ip_address => floatingip.ip})
	 		end
 		end
	end

	def server_status(name)
		status = "Gone"
		@os.servers.each do |server|
	    if (server[:name] == name)
	      status = @os.server(server[:id]).status + ": " + get_server_ip_address(name)
	    end
	  end
	  status
	end

end




