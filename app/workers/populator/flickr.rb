require 'flickr_api'

class Populator::Flickr
  include SidekiqStatus::Worker
  sidekiq_options :queue => :default, :backtrace => true

  def perform(event_id)
    event = Event.find(event_id)

    FlickrAPI.search(
        event.venue.latitude, event.venue.longitude, 
        event.local_start_time, event.local_end_time).each do |photo|
      event.posts << Post::FlickrPhoto.build_from_hashie(FlickrAPI.get_info(photo.id, photo.secret))
    end
  end
end