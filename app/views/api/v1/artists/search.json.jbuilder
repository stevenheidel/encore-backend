json.artists do
  json.array! @artists do |artist|
    json.name artist.name
    json.songkick_id artist.id
  end
end