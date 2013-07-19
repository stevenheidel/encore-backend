require 'lastfm_api'

class Geo
  attr_reader :radius

  def point
    [@long, @lat]
  end

  def initialize(latitude, longitude, radius=0.5)
    @lat = latitude.to_f
    @long = longitude.to_f
    @radius = (radius || 0.5).to_f * 50.0 # Default to half of 50 miles
  end

  def past_events
    Event.in_radius(self).limit(30)
  end

  def todays_events
    events = LastfmAPI.geo_getEvents(@lat, @long, @radius).map do |e| 
      Lastfm::Event.new(e)
    end

    events.keep_if { |e| e.date == Date.today }
  end

  def future_events
    events = LastfmAPI.geo_getEvents(@lat, @long, @radius).map do |e| 
      Lastfm::Event.new(e)
    end

    events.keep_if { |e| e.date > Date.today }
  end
end