# remember that this is coming from the DATABASE

json.concerts do
  json.array! @concerts do |concert|
    json.songkick_id concert.songkick_uuid
    json.name concert.name
    json.date concert.date
    json.start_time concert.start_time
    json.venue_name concert.venue.name
  end
end