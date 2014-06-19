action :create do
	new_resource.app_names.split(',').each do |app_name|
		exec_str="cd /home/#{node[:user]}; git clone #{node['repository']}#{app_name}.git"
		log "Exec #{exec_str}"
		`#{exec_str}`
		exec_str="su -l root -c 'cd /home/#{node[:user]}/#{app_name}; bundle install'"
		log "Exec #{exec_str}"
		`#{exec_str}`
		exec_str="su -l root -c 'cd /home/#{node[:user]}/#{app_name}; rake db:migrate'"
		log "Exec #{exec_str}"
		`#{exec_str}`
	end
end