class Populator::Start
  include Sidekiq::Worker

  def perform(event_id)
    # Create a timecapsule that belongs to event
    event = Event.find(event_id)

    unless Time.now < event.start_time # don't populate if event is in the future
      Populator::Instagram.perform_async(event_id)
      Populator::Flickr.perform_async(event_id)
    end
  end
end