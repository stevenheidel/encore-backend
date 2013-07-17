class Event
  include Concerns::Lastfmable
  
  field :flickr_tag, type: String
  field :headliner, type: String
  field :start_date, type: DateTime
  field :local_start_time, type: DateTime

  field :sidekiq_workers, type: Array, default: []

  has_and_belongs_to_many :artists, index: true
  has_many :posts
  has_and_belongs_to_many :users, index: true
  belongs_to :venue, index: true

  scope :past, where(:start_date.lt => Time.now).desc(:start_date)
  scope :future, where(:start_date.gte => Time.now).asc(:start_date)

  scope :in_radius, ->(point, radius) {
    # 3959 is a magic number for miles
    command = Venue.geo_near(point).distance_multiplier(3959).max_distance(radius/3959.0).spherical
    venue_ids = command.map(&:_id)
    where(:venue_id.in => venue_ids)
  }

  # Is the event currently waiting for photos and videos?
  def populating?
    self.sidekiq_workers.each do |job_id|
      begin
        status = SidekiqStatus::Container.load(job_id).status
      rescue SidekiqStatus::Container::StatusNotFound
        self.sidekiq_workers.delete(status)
        self.save
        next
      end

      if status == 'waiting' || status == 'working'
        return true
      else # status either :complete, :failed, or nil
        self.sidekiq_workers.delete(status)
        self.save
      end
    end

    return false
  end

  def populated?
    self.posts.count > 0
  end

  # Populate the event
  def populate!
    self.sidekiq_workers << Populator::Start.perform_async(self.id.to_s)
    self.save
  end

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
