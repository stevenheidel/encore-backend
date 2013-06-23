require 'songkick_api'

# Populates a list of today's concerts every day and schedules population on them at their start time
class TodaysConcerts
  include Sidekiq::Worker

  def perform(date, city)
    # TODO: assuming all of today's concerts fit into one API call
    location = SongkickAPI.location_search(city).first.metroArea.id
    concerts = SongkickAPI.metroarea_upcoming(location)

    concerts = concerts.keep_if{|c| c.start.date == date}

    concerts.each do |c|
      concert = Concert.build_from_hashie(c)
      concert.save

      # schedule live population during concert
      ConcertPopulator.perform_async(concert.id)
    end
  end
end