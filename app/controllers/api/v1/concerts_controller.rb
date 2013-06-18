require 'songkick_api'

class Api::V1::ConcertsController < Api::V1::BaseController
  def index
    if params[:user_id]
      @concerts = User.find_by(:facebook_uuid => params[:user_id]).concerts.order("date ASC").includes(:venue)
      @concerts_past = @concerts.where("date < ?", Date.today)
      @concerts_future = @concerts.where("date >= ?", Date.today)
    end
  end

  def show
    @concert = Concert.find(params[:id])
  end

  def create
    concert = Concert.find_by(songkick_uuid: params[:songkick_id].to_i)

    unless concert
      e = SongkickAPI.get_event_by_id(params[:songkick_id])

      concert = Concert.build_from_hashie(e)
      concert.save
    end

    # Populate the concert
    ConcertPopulator.perform_async(concert.id) unless concert.populated

    u = User.find_by(facebook_uuid: params[:user_id].to_i)
    u.concerts << concert

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end

  def past
    if params[:artist_id] # get past for artist
      @concerts = SongkickAPI.artist_gigography_city(params[:artist_id], params[:city]).reverse
    else # get popular past for city
      @concerts = []
    end
  end

  def future
    if params[:artist_id] # get future for artist
      @concerts = SongkickAPI.artist_upcoming_city(params[:artist_id], params[:city])
    else # get popular future for city
      location = SongkickAPI.location_search(params[:city]).first.metroArea.id
      @concerts = SongkickAPI.metroarea_upcoming(location)

      # don't include today's concerts
      @concerts.delete_if {|c| c.start.date == Date.today.strftime("%F")}
    end
  end

  def today
    @concerts = Concert.where("date = ?", Date.today).includes(:venue)
  end
end