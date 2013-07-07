json.events do
  json.past do
    json.array! @events_past do |event|
      json.extract! event, :lastfm_id, :name, :date, :image_url
      json.venue_name event.venue.name
    end
  end

  json.future do
    json.array! @events_future do |event|
      json.extract! event, :lastfm_id, :name, :date, :image_url
      json.venue_name event.venue.name
    end
  end
end