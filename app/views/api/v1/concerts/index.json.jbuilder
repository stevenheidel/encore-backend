json.concerts do
  json.past do
    json.array! @concerts_past do |concert|
      json.server_id concert.id
      json.extract! concert, :name, :date
      json.venue_name concert.venue.name
    end
  end

  json.future do
    json.array! @concerts_future do |concert|
      json.server_id concert.id
      json.extract! concert, :name, :date
      json.venue_name concert.venue.name
    end
  end
end