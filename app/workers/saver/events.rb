class Saver::Events
  include Sidekiq::Worker
  sidekiq_options :queue => :saver, :backtrace => true

  def perform(lastfm_json)
    lastfm_event = Lastfm::Event.new(lastfm_json)

    event = Event.find_or_create_by(lastfm_id: lastfm_event.lastfm_id)
    event.update_from_lastfm(lastfm_event)

    venue = Venue.find_or_create_by(lastfm_id: lastfm_event.venue.lastfm_id)
    venue.update_from_lastfm(lastfm_event.venue)
    venue.geo = Geo.get(lastfm_event.venue.city, lastfm_event.venue.country)
    venue.save!

    event.venue = venue

    # TODO: causes a lot of Artists is invalid errors which resolve themselves
    lastfm_event.artists.each do |a| 
      event.artists << Artist.find_or_create_by(lastfm_id: a)
    end

    event.save!
  end
end