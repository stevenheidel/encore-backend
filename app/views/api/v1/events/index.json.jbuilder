json.events do
  json.array! @events do |event| # TODO: easier way to do params
    json.extract! event, :lastfm_id, :name
    #json.date event.date # TODO
    #json.start_time event.start_time # TODO
    json.venue_name event.venue.name
  end
end