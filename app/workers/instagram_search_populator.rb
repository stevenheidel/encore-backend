require 'instagram_api'

class InstagramSearchPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    concert = Concert.find(concert_id)

    InstagramAPI.media_search(concert.venue.latitude, concert.venue.longitude,
          concert.start_time, concert.end_time).each do |media|
      concert.instagram_photos << InstagramPhoto.build_from_hashie(media)
    end
  end
end