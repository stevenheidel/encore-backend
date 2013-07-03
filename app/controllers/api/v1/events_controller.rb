class Api::V1::EventsController < Api::V1::BaseController
  def index
    if params[:lastfm_id]
      # TODO: awfully complicated line
      found = User.find_by(facebook_id: params[:user_id].to_i).events.where(lastfm_id: params[:lastfm_id].to_i).exists?
      
      render 'api/v1/base/result.json', locals: {result: found}
    else
      # TODO: awfully complicated line
      @events = User.find_by(facebook_id: params[:user_id]).events.order_by(:date.asc).includes(:venue)
      @events_past = @events.past
      @events_future = @events.future

      render 'api/v1/events/past_future.json'
    end
  end

  def show
    @event = Event.get(params[:id])
  end

  def create
    event = Event.get(params[:lastfm_id])

    user = User.get(params[:user_id])
    if user.events.include?(event) # already been added to profile
      render 'api/v1/base/result.json', locals: {result: 'already added'}
    else
      user.events << event

      # TODO: this should eventually go somewhere else ie. model
      # Populate the event
      # ConcertPopulator.perform_async(event.id.to_s)

      render 'api/v1/base/result.json', locals: {result: 'success'}
    end
  end

  def past
    if params[:artist_id] # get past for artist
      @events = Artist.get(params[:artist_id]).past_events(params[:city])
    else # get popular past for city
      @events = Geo.get(params[:city]).past_events
    end

    render 'api/v1/events/index.json'
  end

  def future
    if params[:artist_id] # get future for artist
      @events = Artist.get(params[:artist_id]).future_events(params[:city])
    else # get popular future for city
      @events = Geo.get(params[:city]).future_events
    end

    render 'api/v1/events/index.json'
  end

  def today
    # Get today's events from Lastfm
    @events = Geo.get(params[:city]).todays_events

    render 'api/v1/events/index.json'
  end

  def destroy
    event = Event.get(params[:id])
    user = User.get(params[:user_id])
    user.events.delete(event)

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end
end