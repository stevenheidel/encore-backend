json.concerts do
  json.past do
    json.array! @concerts_past do |concert|
      json.songkick_id concert.songkick_uuid
      json.extract! concert, :name, :date
      json.venue_name concert.venue.name
      # TODO: better way of doing this later
      if concert.artist
        json.image_url "http://www1.sk-static.com/images/media/profile_images/artists/#{concert.artist.songkick_uuid}/avatar"
      else
        json.image_url nil
      end
    end
  end

  json.future do
    json.array! @concerts_future do |concert|
      json.songkick_id concert.songkick_uuid
      json.extract! concert, :name, :date
      json.venue_name concert.venue.name
      if concert.artist
        json.image_url "http://www1.sk-static.com/images/media/profile_images/artists/#{concert.artist.songkick_uuid}/avatar"
      else
        json.image_url nil
      end
    end
  end
end