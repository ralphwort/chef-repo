json.array!(@flavors) do |flavor|
  json.extract! flavor, :id, :name, :flavor_id
  json.url flavor_url(flavor, format: :json)
end
