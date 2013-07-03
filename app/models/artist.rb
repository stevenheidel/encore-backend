class Artist
  include Lastfmable

  field :mbid, type: String

  # have we got the events from Lastfm yet?
  field :events_retrieved, type: Boolean, default: {past: false, future: false}

  has_and_belongs_to_many :events

  def past_events(city)
    retrieve_events(:past)

    self.events.past.in_geo(Geo.get(city))
  end

  def future_events(city)
    retrieve_events(:future)

    self.events.future.in_geo(Geo.get(city))
  end

  def self.search(term)
    results = LastfmAPI.artist_search(term)

    results.each do |a|
      a.id = a.name
      Artist.get_or_set(a)
    end

    results
  end

  def fill(response=nil)
    response ||= LastfmAPI.artist_getInfo(self.lastfm_id)

    fill_defaults(response)
    self.lastfm_id = response.name # for artists, name is id

    self.mbid = response.mbid
  end

  private

    # TODO: this will need to be updated occasionally (in the background)
    # TODO: move to a concern, lastfm_cachable or something for both geo and artist
    def retrieve_events(tense)
      return if self.events_retrieved[tense.to_s]

      case tense
      when :past
        response = LastfmAPI.artist_getPastEvents_all(self.lastfm_id)
      when :future
        response = LastfmAPI.artist_getEvents_all(self.lastfm_id)
      end

      response.each do |e|
        Event.get_or_set(e)
      end

      self.reload # Event.get_or_set already sets up artist relationships
      self.events_retrieved[tense] = true
      self.save
    end
end
