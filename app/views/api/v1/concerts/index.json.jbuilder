json.concerts do
  json.array! @concerts do |concert|
    json.server_id concert.id
    json.extract! concert, :name, :date
    json.venue_name concert.venue.name
  end
end