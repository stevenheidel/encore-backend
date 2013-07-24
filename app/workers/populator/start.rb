class Populator::Start < Populator::Base
  def perform(event_id)
    # Create a timecapsule that belongs to event
    event = Event.find(event_id)

    unless Time.now < event.start_time # don't populate if event is in the future
      if Post::InstagramPhoto.where(event: event).empty? || event.live?
        event.sidekiq_workers << Populator::Instagram.perform_async(event_id)
      end

      if Post::FlickrPhoto.where(event: event).empty? || event.live?
        event.sidekiq_workers << Populator::Flickr.perform_async(event_id)
      end

      if Post::YoutubeVideo.where(event: event).empty? || event.live?
        event.sidekiq_workers << Populator::Youtube.perform_async(event_id)
      end
      
      event.save
    end
  end
end