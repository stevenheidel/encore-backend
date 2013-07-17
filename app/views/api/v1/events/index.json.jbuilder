json.events do
  json.array! @events do |event|
    json.extract! event, :lastfm_id, :name, :date, :image_url
    json.venue_name event.venue.name
  end
end