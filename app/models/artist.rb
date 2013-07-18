# TODO: take into account that sometimes artists won't be populated with info

class Artist
  include Concerns::Lastfmable

  field :mbid, type: String

  has_and_belongs_to_many :events, index: true

  def self.search(term)
    LastfmAPI.artist_search(term).map { |a| Lastfm::Artist.new(a) }
  end

  # Name and lastfm_id are synonyms
  def name
    self.lastfm_id
  end

  def past_events(latitude, longitude)
    events = self.events.past
    lastfm_count = LastfmAPI.artist_getPastEvents_count(self.lastfm_id)

    # Check if database is current
    if events.count == lastfm_count # TODO: && the first event itself matches entirely
      # return only those in the correct radius
      events = events.in_radius([longitude.to_f, latitude.to_f], 20)
    else
      # extract above comparison to method

      # TODO: at some point you have to wipe the current list of events, maybe? (cancelled)
      # if not current, make array of Lastfm::Event objects from API call
      events = LastfmAPI.artist_getPastEvents_all(self.lastfm_id, lastfm_count).map do |e|
        Saver::Events.perform_async(e) # send to worker to save to database

        Lastfm::Event.new(e)
      end

      # return only those in the correct radius
      events.keep_if { |e| e.venue.try(:in_radius?, [longitude.to_f, latitude.to_f], 20) }
    end

    events
  end

  def future_events(latitude, longitude)
    LastfmAPI.artist_getEvents_all(self.lastfm_id).map do |e|
      Lastfm::Event.new(e)
    end.keep_if { |e| e.venue.try(:in_radius?, [longitude.to_f, latitude.to_f], 20) }
  end
end
