class Chefapi

	def bootstrap_node(ip_address, os_user, node_name, signing_file, initial_recipe, sleep_time, apps)
		exec_str = "knife_bootstrap.sh " + ip_address + " " + signing_file + " " +  os_user + " " + node_name + " " + initial_recipe + " " + apps
		BootstrapInstance.perform_async(exec_str, sleep_time)
 	end

end