require "ridley"

class OpenstackActionsController < ApplicationController

	def openstack_start_instance(instance_name, os_username, os_password, os_auth_url, flavor_id, image_id)
		os = OpenStack::Connection.create({:username => os_username, :api_key=> os_password, :auth_method=>"password",
  		:auth_url => os_auth_url, :authtenant_name => os_username, :service_type=>"compute"})
		flavor = os.get_flavor(flavor_id)
		image = os.get_image(image_id)
		newserver = os.create_server(:name => instance_name, :imageRef => image.id, :flavorRef => flavor.id, :key_name => "rw1")
		allocated_floating_ip_id = ""
		os.get_floating_ips.each do |floatingip|
		  if (floatingip.fixed_ip.to_s.empty?)
		    allocated_floating_ip_id = floatingip.id
		    break
		  end
		end
		newserver.id
	end

	def openstack_get_floating_ip(os_username, os_password, os_auth_url)
		os = OpenStack::Connection.create({:username => os_username, :api_key=> os_password, :auth_method=>"password",
  		:auth_url => os_auth_url, :authtenant_name => os_username, :service_type=>"compute"})
		allocated_floating_ip_id = ""
		os.get_floating_ips.each do |floatingip|
		  if (floatingip.fixed_ip.to_s.empty?)
		    allocated_floating_ip_id = floatingip.id
		    break
		  end
		end
		allocated_floating_ip_id
	end

	def openstack_allocation_floating_ip(os_username, os_password, os_auth_url, newserver_id, allocated_floating_ip_id)
		os = OpenStack::Connection.create({:username => os_username, :api_key=> os_password, :auth_method=>"password",
  		:auth_url => os_auth_url, :authtenant_name => os_username, :service_type=>"compute"})
		os.attach_floating_ip({:server_id=>newserver_id, :ip_id=>allocated_floating_ip_id})
	end

	def openstack_wait_for_instance_to_be_built(os_username, os_password, os_auth_url, newserver_id)
		server_status = "BUILD"
		while(server_status == "BUILD")
			os = OpenStack::Connection.create({:username => os_username, :api_key=> os_password, :auth_method=>"password",
			  		:auth_url => os_auth_url, :authtenant_name => os_username, :service_type=>"compute"})
			os.servers.each do |server|
		    if (server[:id] == newserver_id)
		      server_tmp = os.server(server[:id])
		      server_status = server_tmp.status
		    end
		  end
		  sleep(1)
		end
	end

	def chef_add_node(name, chef_server_url, client_name, signing_key_file)
		ridley = Ridley.new(
		  server_url: chef_server_url,
		  client_name: client_name,
		  client_key: signing_key_file,
		  ssl: {verify: false}
		)
	  ridley.node.create(name: params[:name])
	end

  def start
  	openstack_user = OpenstackUser.find(params[:openstack_user])
  	newserver_id = openstack_start_instance(params[:name], openstack_user[:os_username], openstack_user[:os_password], openstack_user[:os_auth_url],
  		"2", "138a49ab-4733-4cf5-93f6-3d4dc3f0019a")
  	openstack_wait_for_instance_to_be_built(openstack_user[:os_username], openstack_user[:os_password], openstack_user[:os_auth_url], newserver_id)
  	allocated_floating_ip_id = openstack_get_floating_ip(openstack_user[:os_username], openstack_user[:os_password], openstack_user[:os_auth_url])
  	openstack_allocation_floating_ip(openstack_user[:os_username], openstack_user[:os_password], openstack_user[:os_auth_url], newserver_id, 
  		allocated_floating_ip_id)
  	chef_add_node(params[:name], openstack_user[:chef_server_url], openstack_user[:client_name], openstack_user[:signing_key_file])

=begin
		ridley = Ridley.new(
				  server_url: "https://chef.rwort.co.uk:443",
				  client_name: "admin",
				  client_key: "/root/chef-repo/.chef/admin.pem",
				  ssl: {verify: false}
				)
	  @Message = r.node.create(name: params[:name])



=begin  	openstack_user = OpenstackUser.find(params[:openstack_user])

  	os = OpenStack::Connection.create({:username => openstack_user[:os_username], :api_key=> openstack_user[:os_password], :auth_method=>"password",
  		:auth_url => openstack_user[:os_auth_url], :authtenant_name => openstack_user[:os_username], :service_type=>"compute"})
		flavor = os.get_flavor(2)
		image = os.get_image("138a49ab-4733-4cf5-93f6-3d4dc3f0019a")
		newserver = os.create_server(:name => "rw1", :imageRef => image.id, :flavorRef => flavor.id, :key_name => ARGV[2])

		allocated_floating_ip_id = ""
		os.get_floating_ips.each do |floatingip|
		  if (floatingip.fixed_ip.to_s.empty?)
		    allocated_floating_ip_id = floatingip.id
		    break
		  end
		end

		server_status = "BUILD"
		while(server_status == "BUILD")
			os = OpenStack::Connection.create({:username => openstack_user[:os_username], :api_key=> openstack_user[:os_password], :auth_method=>"password",
	  		:auth_url => openstack_user[:os_auth_url], :authtenant_name => openstack_user[:os_username], :service_type=>"compute"})
			os.servers.each do |server|
		    if (server[:id] == newserver.id)
		      server_tmp = os.server(server[:id])
		      server_status = server_tmp.status
		    end
		  end
		  sleep(1)
		end
		os.attach_floating_ip({:server_id=>newserver.id, :ip_id=>allocated_floating_ip_id})

		# now add node

  	openstack_user = OpenstackUser.find(params[:openstack_user])
  	chef_server_url = openstack_user[:chef_server_url]
		client_name = openstack_user[:client_name]
		signing_key_filename=File.dirname(__FILE__) + openstack_user[:signing_key_file]
=end
  end

  def get_cookbooks
  	openstack_user = OpenstackUser.find(params[:openstack_user])
  	chef_server_url = openstack_user[:chef_server_url]
		client_name = openstack_user[:client_name]
		signing_key_filename=File.dirname(__FILE__) + openstack_user[:signing_key_file]
		 
		rest = Chef::REST.new(chef_server_url, client_name, openstack_user[:signing_key_file])

		cookbooks = rest.get_rest("/cookbooks/")
		
		@message = ""
		cookbooks.keys.each do |cookbook|
			@Message = rest.get_rest("/cookbooks/#{cookbook}/") 
		end
  	@Message
  end
end


