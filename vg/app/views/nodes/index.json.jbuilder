json.array!(@nodes) do |node|
  json.extract! node, :id, :openstack_user_id, :name, :recipe
  json.url node_url(node, format: :json)
end
