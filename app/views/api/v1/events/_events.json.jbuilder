json.array! events do |event|
  json.extract! event, :lastfm_id, :name, :date, :image_url
  json.venue_name event.venue.try(:name)
  json.venue do
    json.extract! event.venue, :street, :city, :postalcode, :country, :coordinates
  end  
  json.headliner event.headliner
  json.artists do
    json.array! event.artists.each do |artist|
      json.artist artist.try(:name) || artist
    end
  end
end
