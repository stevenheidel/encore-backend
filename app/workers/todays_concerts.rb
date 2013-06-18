require 'songkick_api'

# Populates a list of today's concerts every day and schedules population on them at their start time
class TodaysConcerts
  include Sidekiq::Worker

  def perform(date, city)
    # TODO: assuming all of today's concerts fit into one API call
    location = SongkickAPI.location_search(city).first.metroArea.id
    concerts = SongkickAPI.metroarea_upcoming(location)

    concerts = concerts.keep_if{|c| c.start.date == date.strftime("%F")}

    concerts.each do |c|
      Concert.build_from_hashie(c).save

      # IMPORTANT TODO: schedule using ConcertPopulator.perform_at in 15min intervals from start to end time
      # https://github.com/mperham/sidekiq/wiki/Scheduled-Jobs
    end
  end
end