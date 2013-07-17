class Api::V1::EventsController < Api::V1::BaseController
  def index
    # Check to see if event on profile
    if params[:lastfm_id]
      # TODO: awfully complicated line
      found = User.get(params[:user_id]).events.where(lastfm_id: params[:lastfm_id].to_i).exists?

      render 'api/v1/base/result.json', locals: {result: found}
    # Otherwise return all events on profile
    else
      begin
        @events = User.get(params[:user_id]).events.includes(:venue)
        @events_past = @events.past
        @events_future = @events.future
      rescue Mongoid::Errors::DocumentNotFound
        # If the user hasn't been created yet then they have no events
        @events_past, @events_future = []
      end

      render 'api/v1/events/past_future.json'
    end
  end

  def show
    @event = Event.get(params[:id])
  end

  def populating
    @event = Event.get(params[:id])
    render 'api/v1/base/result.json', locals: {result: @event.populating?}
  end

  # Add an event to a user
  def create
    event = Event.find_or_create_from_lastfm(params[:lastfm_id])

    user = User.get(params[:user_id])
    if user.events.include?(event) # already been added to profile
      render 'api/v1/base/result.json', locals: {result: 'already added'}
    else
      user.events << event

      # Populate the event
      event.populate!

      render 'api/v1/base/result.json', locals: {result: 'success'}
    end
  end

  def past
    if params[:artist_id] # get past for artist
      @events = Artist.find_or_create_from_lastfm(params[:artist_id]).past_events(params[:city])
    else # get popular past for location
      @events = Geo.new(params[:latitude], params[:longitude]).past_events
    end

    render 'api/v1/events/index.json'
  end

  def today
    # Get today's events from Lastfm
    @events = Geo.new(params[:latitude], params[:longitude]).todays_events

    render 'api/v1/events/index.json'
  end

  def future
    if params[:artist_id] # get future for artist
      @events = Artist.find_or_create_from_lastfm(params[:artist_id]).future_events(params[:city])
    else # get popular future for location
      @events = Geo.new(params[:latitude], params[:longitude]).future_events
    end

    render 'api/v1/events/index.json'
  end

  def destroy
    event = Event.get(params[:id])
    user = User.get(params[:user_id])
    user.events.delete(event)

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end
end