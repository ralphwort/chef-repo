action :create do
	file new_resource.path do
		content "#{new_resource.contents}"
	end
end