class Populator::Start
  include SidekiqStatus::Worker
  sidekiq_options :queue => :default, :backtrace => true

  def perform(event_id)
    # Create a timecapsule that belongs to event
    event = Event.find(event_id)

    unless Time.now < event.start_time # don't populate if event is in the future
      event.sidekiq_workers << Populator::Instagram.perform_async(event_id)
      event.sidekiq_workers << Populator::Flickr.perform_async(event_id)
      event.save
    end
  end
end