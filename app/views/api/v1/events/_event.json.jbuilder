json.extract! event, :lastfm_id, :name, :date, :start_time, :image_url
json.lastfm_url event.url
json.tickets_url event.tickets_url

json.venue_name event.venue.try(:name)
json.venue do
  json.extract! event.venue, :street, :city, :postalcode, :country, :latitude, :longitude
end  

json.headliner event.headliner
json.artists do
  json.array! event.artists do |artist|
    json.artist artist.try(:name) || artist
  end
end