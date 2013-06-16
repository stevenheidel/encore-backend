json.artists do
  json.array! @artists do |artist|
    json.name artist.name
    json.server_id artist.id
  end
end