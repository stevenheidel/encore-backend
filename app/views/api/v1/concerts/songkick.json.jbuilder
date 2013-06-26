json.concerts do
  json.array! @concerts do |concert|
    json.songkick_id concert.id
    json.name concert.performance[0].displayName
    json.date concert.start.date
    json.start_time concert.start.time
    json.venue_name concert.venue.displayName
    json.image_url "http://www1.sk-static.com/images/media/profile_images/artists/#{concert.performance[0].artist.id}/avatar"
    json.background_url "http://www1.sk-static.com/images/media/profile_images/artists/#{concert.performance[0].artist.id}/col3"
  end
end