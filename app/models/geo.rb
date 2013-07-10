require 'lastfm_api' # geo is not part of lastfmable, so need to include this here

class Geo
  include Mongoid::Document

  field :city, type: String
  field :country, type: String

  has_many :venues

  index({city: 1}, {unique: true})

  validates_uniqueness_of :city, scope: :country

  # TODO: sometimes American cities are stored as "City, State 2 letter code"
  def self.get(city, country=nil)
    if country
      self.find_or_create_by(city: city, country: country)
    else
      self.find_or_create_by(city: city)
    end
  end

  def past_events
    # TODO: do this, by past searching on venues in the geo maybe?
    []
  end

  def todays_events
    # TODO: do this, keep in mind caching this could throw off past events count!
    LastfmAPI.geo_getEvents(self.city).map { |e| Lastfm::Event.new(e) }
  end

  def future_events
    LastfmAPI.geo_getEvents(self.city).map { |e| Lastfm::Event.new(e) }
  end
end