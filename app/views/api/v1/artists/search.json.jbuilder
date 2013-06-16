json.artists do
  json.array! @artists do |artist|
    json.name artist.name
  end
end