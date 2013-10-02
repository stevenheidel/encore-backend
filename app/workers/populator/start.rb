class Populator::Start < Populator::Base
  def perform(event_id)
    # Create a timecapsule that belongs to event
    event = Event.find(event_id)

    unless Time.now < event.start_time # don't populate if event is in the future
      if event.instagram_photos.empty? || event.live?
        event.sidekiq_workers << Populator::Instagram.perform_async(event_id)
      end

      if event.flickr_photos.empty? || event.live?
        event.sidekiq_workers << Populator::Flickr.perform_async(event_id)
      end

      if event.youtube_videos.empty? || event.live?
        event.sidekiq_workers << Populator::Youtube.perform_async(event_id)
      end
      
      event.save
    end
  end
end