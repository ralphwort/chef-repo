json.array!(@volumes) do |volume|
  json.extract! volume, :id, :name, :status, :volume_id
  json.url volume_url(volume, format: :json)
end
