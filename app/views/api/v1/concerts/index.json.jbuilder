json.concerts do
  json.past do
    json.array! @concerts_past do |concert|
      json.songkick_id concert.songkick_uuid
      json.extract! concert, :name, :date
      json.venue_name concert.venue.name
    end
  end

  json.future do
    json.array! @concerts_future do |concert|
      json.songkick_id concert.songkick_uuid
      json.extract! concert, :name, :date
      json.venue_name concert.venue.name
    end
  end
end