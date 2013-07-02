json.events do
  json.past do
    json.array! @events_past do |event|
      json.extract! event, :lastfm_id, :name
      #json.date # TODO
      json.venue_name event.venue.name
      #json.image_url # TODO
    end
  end

  json.future do
    json.array! @events_future do |event|
      json.extract! event, :lastfm_id, :name
      #json.date # TODO
      json.venue_name event.venue.name
      #json.image_url # TODO
    end
  end
end