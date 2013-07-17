require 'lastfm_api'

class Geo
  def initialize(latitude, longitude)
    @lat = latitude.to_f
    @long = longitude.to_f
  end

  def past_events
    Event.in_radius([@long, @lat], 20)
  end

  def todays_events
    # TODO: do this, keep in mind caching this could throw off past events count!
    events = LastfmAPI.geo_getEvents(@lat, @long).map do |e| 
      Saver::Events.perform_async(e) # send to worker to save to database

      Lastfm::Event.new(e)
    end

    events.keep_if { |e| e.date == Date.today }
  end

  def future_events
    LastfmAPI.geo_getEvents(self.city).map { |e| Lastfm::Event.new(e) }
  end
end