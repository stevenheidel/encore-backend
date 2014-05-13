class Saver::UpdateEvent
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :backtrace => false

  # Update an event with new info
  def perform(lastfm_id)
    lastfm_event = Lastfm::Event.new(LastfmAPI.event_getInfo(lastfm_id))
    
    Event.find_or_create_from_lastfm(lastfm_id, lastfm_event)
  end
end
