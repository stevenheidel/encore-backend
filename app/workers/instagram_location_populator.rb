require 'instagram_api'

class InstagramLocationPopulator
  include Sidekiq::Worker

  def perform(concert_id, instagram_location_id, instagram_max_id=nil)
    concert = Concert.find(concert_id)

    result = InstagramAPI.location_recent_media(
      instagram_location_id, 
      concert.start_time, concert.end_time,
      instagram_max_id
    )
    
    if (max_id = result.pagination.next_max_id)
      InstagramLocationPopulator.perform_async(concert_id, instagram_location_id, max_id)
    end

    result.each do |media|
      concert.instagram_photos << InstagramPhoto.build_from_hashie(media)
    end
  end
end