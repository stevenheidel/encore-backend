# == Schema Information
#
# Table name: events
#
#  id               :uuid             not null, primary key
#  lastfm_id        :string(255)
#  name             :string(255)
#  website          :string(255)
#  url              :string(255)
#  flickr_tag       :string(255)
#  headliner        :string(255)
#  start_date       :datetime
#  local_start_time :datetime
#  tickets_url      :string(255)
#  venue_id         :uuid
#  created_at       :datetime
#  updated_at       :datetime
#  sidekiq_workers  :string(255)      default([])
#

class Event < ActiveRecord::Base
  include Concerns::Lastfmable

  has_and_belongs_to_many :artists
  has_and_belongs_to_many :users

  has_many :flickr_photos, class_name: "Post::FlickrPhoto"
  has_many :instagram_photos, class_name: "Post::InstagramPhoto"
  has_many :user_photos, class_name: "Post::UserPhoto"
  has_many :youtube_videos, class_name: "Post::YoutubeVideo"

  has_many :friend_visitors, class_name: "Event::FriendVisitor"

  belongs_to :venue

  validates_presence_of :artists
  validates_presence_of :start_date
  before_save :normalize_start_date

  scope :past, lambda{ where("start_date < ?", Time.now).order('start_date DESC') }
  scope :future, lambda{ where("start_date >= ?", Time.now).order('start_date ASC') }
  
  scope :popular, ->(limit) {
    # TODO: write this
  }

  AMOUNT_OF_TODAYS_EVENTS = 20

  scope :in_radius, ->(geo) {
    # This is actual magic. See https://github.com/alexreisner/geocoder#known-issue
    venue_ids = Venue.near(geo.point, geo.radius).joins(:events).preload(:events).map(&:id)
    where('venue_id in (?)', venue_ids)
  }

  # Is the event currently waiting for photos and videos?
  def populating?
    self.sidekiq_workers.each do |job_id|
      begin
        status = SidekiqStatus::Container.load(job_id).status
      rescue SidekiqStatus::Container::StatusNotFound
        self.sidekiq_workers.delete(job_id)
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

  def local_date
    self.local_start_time.to_date
  end

  def start_time
    self.start_date
  end

  def local_start_time
    self[:local_start_time] ||= self.start_time + 
      GoogleTimezone.fetch(*self.venue.coordinates).raw_offset.seconds
    # GoogleTimezone needs latitude, longitude order
  end

  def end_time
    self.start_time + 6.hours # SMELL: arbitralily add 6 hours for end of event
  end

  def local_end_time
    self.local_start_time + 6.hours
  end

  # Is the event currently taking place?
  def live?
    self.start_time < Time.now && Time.now < self.end_time
  end

  # Get all types of posts
  def posts
    Post.all_for_event(self.id)
  end

  def friends_who_attended(user)
    friend_visitors.where(user: user).to_a.map {|company| company.friend}
  end

  def to_json
    {
      _id: id,
      created_at: format_datetime(created_at.utc),
      updated_at: format_datetime(updated_at.utc),
      lastfm_id: lastfm_id,
      name: name,
      website: website,
      url: url,
      flickr_tag: flickr_tag,
      headliner: headliner,
      start_date: format_datetime(start_date.utc, {with_timezone: true}),
      local_start_time: format_datetime(local_start_time),
      sidekiq_workers: sidekiq_workers,
      artist_ids: artist_ids,
      user_ids: user_ids,
      venue_id: venue_id,
      user_count: users.count
    }.to_json
  end

  # retrieve a large enough amount of events to ensure that 
  # the requested events page will be found (as the pagination is happening on backend and not LastfmAPI) 
  def self.lastfm_events_total_page_size(options={})
    todays_events = options[:exclude_todays_events] ? self::AMOUNT_OF_TODAYS_EVENTS : 0
    if(   options[:page].nil?     and options[:limit].present?)
      return options[:limit] + todays_events
    elsif(options[:page].present? and options[:limit].present?)
      page  = options[:page].to_i
      limit = options[:limit].to_i
      return (page * limit) + limit + todays_events
    else
      return 30 + todays_events
    end
  end

  # As there is a need to filter out the events happening today for Geo#future_events, 
  # the lastfmAPI pagination cannot be used. Instead, pagination is applied after 
  # the events are retrieved from lastfmAPI. Pages start from 1, not 0
  def self.paginate_events(events, pagination)
    pagination[:page]  ||= 1
    pagination[:limit] ||= 30
    page = pagination[:page].to_i
    limit = pagination[:limit].to_i
    starting_index = (page-1) * limit
    starting_index = 0 if starting_index < 0
    return [] if starting_index > events.length-1
    ending_index = (page * limit)-1
    ending_index = events.length-1 if ending_index > events.length-1

    events[starting_index..ending_index]
  end

  private
  def format_datetime datetime, options={}
    format = "%a, %d %b %Y %H:%M:%S"
    format += " %z" if options[:with_timezone]
    datetime.strftime(format)
  end

  def normalize_start_date
    self.start_date = Time.at((self.start_date.to_f / 30.minutes).round * 30.minutes)
  end
end
