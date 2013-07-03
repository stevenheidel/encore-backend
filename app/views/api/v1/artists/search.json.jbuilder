json.artists do
  json.array! @artists do |artist|
    json.name artist.name
    json.lastfm_id artist.name
  end
end