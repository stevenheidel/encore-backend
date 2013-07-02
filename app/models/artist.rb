class Artist
  include Mongoid::Document
  include Mongoid::Timestamps

  include Lastfmable

  field :mbid, type: String

  has_and_belongs_to_many :events

  def fill(response=nil)
    response ||= LastfmAPI.artist_getInfo(self.lastfm_id)

    fill_defaults(response)
    self.lastfm_id = response.name # for artists, name is id

    self.mbid = response.mbid
  end

  # TODO: perhaps should be a geo model?
  def past_events(city)
    unless past_event_count == LastfmAPI.artist_getPastEvents_count(self.lastfm_id)
      LastfmAPI.artist_getPastEvents_all(self.lastfm_id).each do |e|
        event = Event.get_or_set(e)
      end
    end

    self.reload # Event.get_or_set already sets up artist relationships
    self.events.past
  end

  # TODO: cached in some way?
  def past_event_count
    self.events.past.count
  end
end
