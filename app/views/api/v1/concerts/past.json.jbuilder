# remember that this is coming from Songkick

json.concerts do
  json.array! @concerts do |concert|
    json.songkick_id concert.id
    json.name concert.displayName
    json.date concert.start.date
    json.start_time concert.start.time
    json.venue_name concert.venue.displayName
  end
end