json.artist do
  json.extract! @artist, :name, :lastfm_id
end

json.others do
  json.array! @others do |other|
    json.name other.name
    json.lastfm_id other.name
  end
end

json.events do
  json.array! @events do |event|
    json.extract! event, :lastfm_id, :name, :date, :image_url
    json.venue_name event.venue.name
  end
end