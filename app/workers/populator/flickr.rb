require 'flickr_api'

class Populator::Flickr
  include Sidekiq::Worker

  def perform(event_id)
    event = Event.find(event_id)

    FlickrAPI.search(
        event.venue.latitude, event.venue.longitude, 
        event.start_time, event.end_time).each do |photo|
      event.posts << Post::FlickrPhoto.build_from_hashie(FlickrAPI.get_info(photo.id, photo.secret))
    end
  end
end