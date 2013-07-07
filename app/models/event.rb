class Event
  include Concerns::Lastfmable
  
  field :flickr_tag, type: String
  field :headliner, type: String
  field :start_date, type: DateTime

  has_and_belongs_to_many :artists
  has_many :posts
  has_and_belongs_to_many :users
  belongs_to :venue

  scope :past, where(:start_date.lt => Time.now).desc(:start_date)
  scope :future, where(:start_date.gte => Time.now).asc(:start_date)

  scope :in_city, ->(city) {
    venue_ids = Venue.where(geo: Geo.get(city)).only(:_id).map(&:_id)
    where(:venue_id.in => venue_ids)
  }

  def date
    self.start_date.to_date
  end
end
