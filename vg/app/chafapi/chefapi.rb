class Chefapi

	def bootstrap_node(ip_address, os_user, node_name, signing_file, initial_recipe, sleep_time, apps)
		exec_str = "knife_bootstrap.sh " + ip_address + " " + signing_file + " " +  os_user + " " + node_name + " " + initial_recipe + " " + apps
		BootstrapInstance.perform_async(exec_str, sleep_time)
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

end