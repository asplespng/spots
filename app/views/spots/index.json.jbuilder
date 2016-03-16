json.array!(@spots) do |spot|
  json.extract! spot, :id, :latitude, :longitude, :radius
  json.url spot_url(spot, format: :json)
end
