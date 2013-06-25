json.songkick_id @concert.songkick_uuid
json.extract! @concert, :name, :date
json.venue_name @concert.venue.name
json.image_url "http://www1.sk-static.com/images/media/profile_images/artists/#{@concert.songkick_uuid}/avatar"