class Saver::PastEvents
  include Sidekiq::Worker
  sidekiq_options :queue => :saver, :backtrace => true

  def perform(artist_id)
    artist = Artist.find_or_create_from_lastfm(artist_id)
    events = artist.retrieve_past_events

    # Loop through each event and save
    events.map! do |lastfm_event|
      event = Event.find_or_create_then_update_from_lastfm(lastfm_event)

      # Not all events have venues on lastfm
      if lastfm_event.venue
        venue = Venue.find_or_create_then_update_from_lastfm(lastfm_event.venue)
        event.venue = venue
        event.save!
      end

      event
    end

    artist.events = events
    artist.past_event_freshness = DateTime.now

    artist.save!
  end
end