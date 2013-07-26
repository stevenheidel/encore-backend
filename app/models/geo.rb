require 'lastfm_api'

class Geo
  attr_reader :radius

  def point
    [@long, @lat]
  end

  # TODO: remember to delete request
  def initialize(latitude, longitude, radius=0.5, request=nil)
    # TODO: default to Toronto due to app not working
    if (latitude.to_i == 0 && longitude.to_i == 0) || (latitude.nil? && longitude.nil?)
      # Try and get lat/long from request object
      begin
        result = request.location

        latitude = result.latitude.to_f
        longitude = result.longitude.to_f
      rescue

      end

      # Otherwise default to Toronto
      if (latitude.to_i == 0 && longitude.to_i == 0) || (latitude.nil? && longitude.nil?)
        latitude = 43.66621
        longitude = -79.39927
      end
    end

    @lat = latitude.to_f
    @long = longitude.to_f
    @radius = (radius || 0.5).to_f * 50.0 # Default to half of 50 miles
  end

  def past_events
    Event.in_radius(self).where(:user_count.gt => 0).order_by(:user_count.desc).limit(30)
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