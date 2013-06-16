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

  end

  def past
    @concerts = SongkickAPI.artist_gigography_city(params[:artist_id], params[:city])

    pp @concerts[0].displayName
    @concerts.each{|c| c.name = c.displayName; c.venue.name = c.venue.displayName}
    pp @concerts[0].venue.name

    render 'api/v1/concerts/index.json'
  end
end