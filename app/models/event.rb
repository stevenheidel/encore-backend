class Event
  include Lastfmable
  
  field :flickr_tag, type: String
  field :headliner, type: String
  field :start_date, type: DateTime

  has_and_belongs_to_many :artists
  has_many :posts
  has_and_belongs_to_many :users
  belongs_to :venue

  scope :past, where(:start_date.lt => Time.now)
  scope :future, where(:start_date.gte => Time.now)

  scope :in_geo, ->(geo) {
    venue_ids = Venue.where(geo: geo).only(:_id).map(&:_id)
    where(:venue_id.in => venue_ids)
  }

  def fill(response=nil)
    response ||= LastfmAPI.event_getInfo(self.lastfm_id)

    fill_defaults(response)
    self.name = response.title

    self.flickr_tag = response.tag 
    self.headliner = response.artists.headliner
    self.start_date = response.startDate

    # Associate with venue
    self.venue = Venue.get_or_set(response.venue)

    # Associate with artists
    # TODO: sometimes artists is an array, other times not
    artists = response.artists.artist
    if artists.kind_of?(String)
      artists = [artists]
    end

    artists.each do |a|
      artist = Artist.find_or_create_by({lastfm_id: a})
      #artist.fill TODO: this should go into some kind of queue
      self.artists << artist
    end
  end
end
