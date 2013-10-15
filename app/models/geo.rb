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
    Event.past.in_radius(self).where(:user_count.gt => 0).order_by(:user_count.desc).limit(30)
  end

  def todays_events
    events = LastfmAPI.geo_getEvents(@lat, @long, @radius).map do |e| 
      Lastfm::Event.new(e)
    end

    events.keep_if { |e| e.date == Date.today }
  end

  def future_events(options={})
    pagination = {page: options[:page], limit: options[:limit]}
    options[:page] = nil ; options[:limit] = 200
    events = LastfmAPI.geo_getEvents(@lat, @long, @radius, options).map do |e| 
      Lastfm::Event.new(e)
    end
    events.keep_if { |e| e.date > Date.today }
    events = paginate_events(events, pagination)
  end

  private

  # As there is a need to filter out the events happening today, the lastfmAPI pagination 
  # cannot be used. Instead, pagination is applied after the events are retrieved from lastfmAPI.
  # Pages start from 1
  def paginate_events(events, pagination)
    pagination[:page]  ||= 1
    pagination[:limit] ||= 30
    page = pagination[:page].to_i
    limit = pagination[:limit].to_i
    starting_index = (page-1) * limit
    starting_index = 0 if starting_index < 0 or starting_index > events.length-1
    ending_index = (page * limit)-1
    ending_index = events.length-1 if ending_index > events.length-1

    events[starting_index..ending_index]
  end
end