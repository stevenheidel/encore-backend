require 'eventful_api'

class EventfulFiller
  include Sidekiq::Worker

  def perform(type, id)
    case type
    when "concert"
      concert = Concert.find(id)
      e = EventfulAPI.event_search(concert.name, concert.venue.location, concert.date)

      concert.start_time = DateTime.parse(e.start_time)
      if e.stop_time
        concert.end_time = DateTime.parse(e.stop_time)
      else
        # Arbitrarily add 6 hours from start time
        concert.end_time = concert.start_time + 6.hours
      end

      concert.save
    when "venue"
      venue = Venue.find(id)
      e = EventfulAPI.venue_search(venue.name, venue.location)

      venue.latitude  = e.latitude
      venue.longitude = e.longitude

      venue.save
    end
  end
end