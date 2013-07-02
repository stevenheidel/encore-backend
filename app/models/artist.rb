class Artist
  include Lastfmable

  field :mbid, type: String

  # have we got the past events from Lastfm yet?
  field :past_events_retrieved, type: Boolean, default: false

  has_and_belongs_to_many :events

  def past_events(city)
    retrieve_past_events unless self.past_events_retrieved

    self.events.past.in_geo(Geo.get(city))
  end

  def fill(response=nil)
    response ||= LastfmAPI.artist_getInfo(self.lastfm_id)

    fill_defaults(response)
    self.lastfm_id = response.name # for artists, name is id

    self.mbid = response.mbid
  end

  private

    # TODO: this will need to be updated occasionally (in the background)
    def retrieve_past_events
      LastfmAPI.artist_getPastEvents_all(self.lastfm_id).each do |e|
        event = Event.get_or_set(e)
      end

      self.reload # Event.get_or_set already sets up artist relationships

      self.past_events_retrieved = true
    end
end
