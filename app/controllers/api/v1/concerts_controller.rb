require 'songkick_api'

class Api::V1::ConcertsController < Api::V1::BaseController
  # TODO: The 'else' should be listings based on location, etc. MAYBE
  def index
    if params[:user_id]
      @concerts = User.find_by(:facebook_uuid => params[:user_id]).concerts.order("date ASC")
      @concerts_past = @concerts.where("date < ?", Date.today)
      @concerts_future = @concerts.where("date >= ?", Date.today)
    else
      @concerts = Concert.all
    end
  end

  def show
    @concert = Concert.find(params[:id])
  end

  def create
    concert = Concert.where(songkick_uuid: params[:songkick_id].to_i).first_or_create do |c|
      e = SongkickAPI.get_event_by_id(params[:songkick_id])

      c.name   = e.displayName
      c.date   = e.start.date
      if e.start.time
        c.start_time = DateTime.parse(e.start.date + "T" + e.start.time)
      else
        # TODO: Arbitrarily choose 6:00 as starting time
        c.start_time = DateTime.parse(e.start.date + "T" + "18:00:00")
      end
      # TODO: Arbitrarily add 6 hours from start time
      c.end_time = c.start_time + 6.hours

      c.venue = Venue.where(songkick_uuid: e.venue.id.to_i).first_or_create do |v|
        v.name     = e.venue.displayName
        v.location = e.location.city
        v.latitude  = e.location.lat
        v.longitude = e.location.lng
      end
    end

    # Populate the concert
    ConcertPopulator.perform_async(concert.id) unless concert.populated

    u = User.find_by(facebook_uuid: params[:user_id].to_i)
    u.concerts << concert

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end

  def past
    @concerts = SongkickAPI.artist_gigography_city(params[:artist_id], params[:city])
  end

  def future
    if params[:artist_id] # get future for artist
      @concerts = SongkickAPI.artist_upcoming_city(params[:artist_id], params[:city])
    else # get future for city
      location = SongkickAPI.location_search(params[:city]).first.metroArea.id
      @concerts = SongkickAPI.metroarea_upcoming(location)
    end
  end
end