require 'flickr_api'

class Populator::Flickr < Populator::Base
  def perform(event_id)
    event = Event.find(event_id)

    FlickrAPI.search(
        event.venue.latitude, event.venue.longitude, 
        event.local_start_time, event.local_end_time).each do |photo|
      event.flickr_photos << Post::FlickrPhoto.build_from_hashie(FlickrAPI.get_info(photo.id, photo.secret))
    end

    FlickrAPI.machine_tag_search(event.flickr_tag).each do |photo|
      event.flickr_photos << Post::FlickrPhoto.build_from_hashie(FlickrAPI.get_info(photo.id, photo.secret))
    end
  end
end