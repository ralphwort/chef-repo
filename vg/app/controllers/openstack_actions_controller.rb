class OpenstackActionsController < ApplicationController
  def start
  	openstack_user = OpenstackUser.find(params[:openstack_user])
  	recipe = params[:recipe]
  	name = params[:name]

=begin
  	os = OpenStack::Connection.create({:username => openstack_user[:os_username], :api_key=> openstack_user[:os_password], :auth_method=>"password",
  		:auth_url => openstack_user[:os_auth_url], :authtenant_name => openstack_user[:os_username], :service_type=>"compute"})
		flavor = os.get_flavor(2)
		image = os.get_image("138a49ab-4733-4cf5-93f6-3d4dc3f0019a")
		newserver = os.create_server(:name => name, :imageRef => image.id, :flavorRef => flavor.id, :key_name => ARGV[2])

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
=end
		# now add node

  	openstack_user = OpenstackUser.find(params[:openstack_user])
  	chef_server_url = openstack_user[:chef_server_url]
		client_name = openstack_user[:client_name]
		signing_key_filename=File.dirname(__FILE__) + openstack_user[:signing_key_file]
		 
		rest = Chef::REST.new(chef_server_url, client_name, openstack_user[:signing_key_file])

body = {
  :overrides => {},
  :name => "rw1",
  :chef_type => "node",
  :json_class =>"Chef::Node",
  :attributes => {},
  :run_list => ["recipe[rw3]"],
  :defaults => {}
}

		cookbooks = rest.put_rest("/nodes/rw1", body.to_json)
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


