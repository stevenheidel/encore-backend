require 'flickr_api'

class FlickrPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    concert = Concert.find(concert_id)

    FlickrAPI.search(
        concert.venue.latitude, concert.venue.longitude, 
        concert.start_time, concert.end_time).each do |photo|
      concert.posts << Post::FlickrPhoto.build_from_hashie(FlickrAPI.get_info(photo.id, photo.secret))
    end
  end
end