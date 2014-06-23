class OpenstackActionsController < ApplicationController

	def action
		openstackapi = Openstackapi.new(params[:openstack_user])
		@Message = params[:activity]
		case params[:activity]
			when 'start'
				newserver_id = openstackapi.start_instance(params[:name], params[:flavors][:flavors], params[:images][:images], params[:openstack_user])
=begin
		  	openstackapi.wait_for_instance_to_be_built(newserver_id)
		  	allocated_floating_ip = openstackapi.get_floating_ip
		  	openstackapi.allocate_floating_ip(newserver_id, allocated_floating_ip[:allocated_floating_ip_id])
		 		chefapi = Chefapi.new
		  	chefapi.bootstrap_node(allocated_floating_ip[:allocated_floating_ip], "cloud-user", params[:name], "/root/chef-repo/rw1.pem", params[:recipe], 30, params[:apps])
=end
		  	flash.alert = "Started " + params[:name]
# + " attached to " + allocated_floating_ip[:allocated_floating_ip].to_s

		  when 'bootstrap_instance'
		 		floating_ip_address = openstackapi.get_server_ip_address(params[:name])
		 		chefapi = Chefapi.new
				chefapi.bootstrap_node(floating_ip_address, "cloud-user", params[:name], "/root/chef-repo/rw1.pem", params[:recipe], 0, params[:apps])
				flash.alert = "Chef Bootstrap " + params[:name] + " attached to " + floating_ip_address

			when 'assign_ip_address'
				server_id = openstackapi.get_server_id(params[:name])
				floating_ip_id = openstackapi.get_floating_ip_id(params[:ip_address][:ip_address])
		  	openstackapi.allocate_floating_ip(server_id, floating_ip_id)
				flash.alert = "Allocated " + floating_ip_id + " to " + floating_ip_id

			when 'deallocate_ip_address'
				server_id = openstackapi.get_server_id(params[:name])
				floating_ip = openstackapi.get_server_ip_address(params[:name])
				floating_ip_id = openstackapi.get_floating_ip_id(floating_ip)
		  	openstackapi.deallocate_floating_ip(server_id, floating_ip_id)
				flash.alert = "Deallocated " + server_id + " from " + floating_ip

	  end
  	redirect_to request.referer
	end

	def server_status
		openstackapi = Openstackapi.new(params[:openstack_user])
		@Message = openstackapi.server_status(params[:node_name])
#		@Message = params[:node_name]
	end

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


