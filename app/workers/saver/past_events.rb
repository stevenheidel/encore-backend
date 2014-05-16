class Saver::PastEvents
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :backtrace => false

  def perform(artist_id)
    artist = Artist.find_or_create_from_lastfm(artist_id)
    events = artist.retrieve_past_events

    # Loop through each event and save
    events.each do |lastfm_event|
      Saver::UpdateEvent.perform_async(lastfm_event.lastfm_id)
    end

    artist.past_event_freshness = DateTime.now

    artist.save!
  end
end
