class Event
  include Concerns::Lastfmable
  
  field :flickr_tag, type: String
  field :headliner, type: String
  field :start_date, type: DateTime
  field :local_start_time, type: DateTime

  has_and_belongs_to_many :artists, index: true
  has_many :posts
  has_and_belongs_to_many :users, index: true
  belongs_to :venue, index: true

  scope :past, where(:start_date.lt => Time.now).desc(:start_date)
  scope :future, where(:start_date.gte => Time.now).asc(:start_date)

  scope :in_city, ->(city) {
    venue_ids = Geo.get(city).venues.only(:_id).map(&:_id)
    where(:venue_id.in => venue_ids)
  }

  def date
    self.start_date.to_date
  end

  def start_time
    self.start_date
  end

  def local_start_time
    self[:local_start_time] ||= self.start_time + 
      GoogleTimezone.fetch(self.venue.latitude, self.venue.longitude).raw_offset.seconds
  end

  def end_time
    self.start_time + 6.hours # TODO: arbitralily add 6 hours for end of event
  end

  def local_end_time
    self.local_start_time + 6.hours
  end
end
