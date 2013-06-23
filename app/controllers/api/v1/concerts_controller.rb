require 'songkick_api'

class Api::V1::ConcertsController < Api::V1::BaseController
  def index
    if params[:songkick_id]
      found = !User.find_by(facebook_uuid: params[:user_id]).concerts.find_by(songkick_uuid: params[:songkick_id]).blank?
      
      render 'api/v1/base/result.json', locals: {result: found}
    else
      @concerts = User.find_by(facebook_uuid: params[:user_id]).concerts.order("date ASC").includes(:venue)
      @concerts_past = @concerts.where("date < ?", Date.today)
      @concerts_future = @concerts.where("date >= ?", Date.today)
    end
  end

  def show
    @concert = Concert.find_by(songkick_uuid: params[:id])
  end

  def create
    concert = Concert.find_by(songkick_uuid: params[:songkick_id])

    unless concert
      e = SongkickAPI.get_event_by_id(params[:songkick_id])

      concert = Concert.build_from_hashie(e)
      concert.save
    end

    user = User.find_by(facebook_uuid: params[:user_id])
    if user.concerts.include?(concert) # already been added to profile
      render 'api/v1/base/result.json', locals: {result: 'already added'}
    else
      # Populate the concert
      ConcertPopulator.perform_async(concert.id)

      user.concerts << concert

      render 'api/v1/base/result.json', locals: {result: 'success'}
    end
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

      # IMPORTANT TODO: Deal with festivals
      @concerts.delete_if {|c| c.type == "Festival"}

      # don't include today's concerts
      @concerts.delete_if {|c| c.start.date == Date.today.strftime("%F")}
    end
  end

  def today
    @concerts = Concert.where("date = ?", Date.today).includes(:venue)
  end

  def destroy
    concert = Concert.find(params[:id])
    user = User.find_by(facebook_uuid: params[:user_id])
    user.concerts.delete(concert)

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end
end