class Api::V1::ConcertsController < Api::V1::BaseController
  # TODO: The 'else' should be listings based on location, etc.
  def index
    if params[:user_id]
      @concerts = User.find(params[:user_id]).concerts
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
end