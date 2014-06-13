json.array!(@openstack_users) do |openstack_user|
  json.extract! openstack_user, :id, :os_username, :os_password, :os_auth_url, :chef_server_url, :client_name, :signing_key_file
  json.url openstack_user_url(openstack_user, format: :json)
end
