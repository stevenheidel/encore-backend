require 'lastfm_api'

class Geo
  include Mongoid::Document

  field :city, type: String
  field :country, type: String

  has_many :venues

  validates_uniqueness_of :city, scope: :country

  def past_events
    
  end

  def todays_events
    
  end

  def future_events
    
  end

  # TODO: sometimes American cities are stored as "City, State 2 letter code"
  def self.get(city)
    self.seed

    self.find_by(city: city)
  end

  def self.get_or_set(city, country)
    self.seed

    self.find_or_create_by(city: city, country: country)
  end

  private

    # Seed from Lastfm's list of metros
    def self.seed
      unless @@seeded ||= false
        LastfmAPI.geo_getMetros_all.each do |metro|
          self.create(city: metro.name, country: metro.country)
        end
        @@seeded = true
      end
    end
end
