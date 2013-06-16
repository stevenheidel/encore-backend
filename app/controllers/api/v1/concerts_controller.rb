require 'songkick_api'

class Api::V1::ConcertsController < Api::V1::BaseController
  # TODO: The 'else' should be listings based on location, etc. MAYBE
  def index
    if params[:user_id]
      @concerts = User.find_by(:facebook_uuid => params[:user_id]).concerts
    else
      @concerts = Concert.all
    end
  end

  def show
    @concert = Concert.find(params[:id])
  end

  # TODO: Add a concert to a user's timecapsule
  def create
    e = SongkickAPI.get_event_by_id(params[:songkick_id])

    concert = Concert.new
    concert.name   = e.displayName
    concert.date   = e.start.date
    if e.start.time
      concert.start_time = DateTime.parse(e.start.date + "T" + e.start.time)
    else
      # TODO: Arbitrarily choose 6:00 as starting time
      concert.start_time = DateTime.parse(e.start.date + "T" + "18:00:00")
    end
    # TODO: Arbitrarily add 6 hours from start time
    concert.end_time = concert.start_time + 6.hours
    concert.songkick_uuid = e.id.to_i

    venue = Venue.where(songkick_uuid: e.venue.id.to_i).first_or_initialize
    venue.name     = e.venue.displayName
    venue.location = e.location.city
    venue.latitude  = e.location.lat
    venue.longitude = e.location.lng
    venue.save

    concert.venue = venue
    concert.save
  end

  def past
    @concerts = SongkickAPI.artist_gigography_city(params[:artist_id], params[:city])
  end
end