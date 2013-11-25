class Api::V1::EventsController < Api::V1::BaseController
  def index
    # Check to see if event on profile
    if params[:lastfm_id]
      # SMELL: awfully complicated line
      found = User.get(params[:user_id]).events.where(lastfm_id: params[:lastfm_id]).exists?

      render 'api/v1/base/result.json', locals: {result: found}
    # Otherwise return all events on profile
    else
      user = User.get(params[:user_id])

      if user
        @events = user.events.includes(:venue)
        @events_past = @events.past
        @events_future = @events.future
      else
        # If the user hasn't been created yet then they have no events
        @events_past, @events_future = []
      end

      render 'api/v1/events/past_future.json'
    end
  end

  def show
    @event = Event.get(params[:id])
  end

  def populate
    event = Event.find_or_create_from_lastfm(params[:id])

    # Populate the event
    event.populate!

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end

  def populating
    @event = Event.get(params[:id])
    render 'api/v1/base/result.json', locals: {result: @event.populating?}
  end

  # Add an event to a user
  def create
    event = Event.find_or_create_from_lastfm(params[:lastfm_id])

    # Populate the event
    event.populate!

    user = User.get(params[:user_id])
    if user.events.include?(event) # already been added to profile
      render 'api/v1/base/result.json', locals: {result: 'already added'}
    else
      user.events << event

      render 'api/v1/base/result.json', locals: {result: 'success'}
    end
  end

  def destroy
    event = Event.get(params[:id])
    user = User.get(params[:user_id])
    user.events.delete(event)

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end

  def past
    geo = Geo.new(params[:latitude], params[:longitude], params[:radius], request)

    if params[:artist_id] # get past for artist
      @events = Artist.find_or_create_from_lastfm(params[:artist_id]).past_events(geo)
    else # get popular past for location
      @events = geo.past_events
    end

    render 'api/v1/events/index.json'
  end

  def today
    geo = Geo.new(params[:latitude], params[:longitude], params[:radius], request)

    # Get today's events from Lastfm
    @events = geo.todays_events

    render 'api/v1/events/index.json'
  end

  def future
    geo = Geo.new(params[:latitude], params[:longitude], params[:radius], request)
    pagination_options = {page: params[:page], limit: params[:limit]}

    if params[:artist_id] # get future for artist
      @events = Artist.find_or_create_from_lastfm(params[:artist_id]).future_events(geo, pagination_options)
      @events_total_count = LastfmAPI.artist_getEvents_count(params[:artist_id])
    else # get popular future for location
      @events = geo.future_events(pagination_options)
      @events_total_count = LastfmAPI.geo_getEvents_count(geo.point[1], geo.point[0], geo.radius, {exclude_todays_events: true})
    end

    render 'api/v1/events/future.json'
  end

  def add_facebook_friends
    begin
      event = Event.get(params[:id])
      user = User.get(params[:user_id])
      user.delete_friends_who_attended_event(event)
      user.add_friends_who_attended_event(event, params[:friends])
      @friends = user.friends_who_attended_event(event)

      render 'api/v1/users/friends.json'
    rescue #Mongoid::Errors::DocumentNotFound
      render 'api/v1/users/friends.json'
    end
  end

  def facebook_friends
    begin
      event = Event.get(params[:id])
      user = User.get(params[:user_id])
      @friends = user.friends_who_attended_event(event)
      render 'api/v1/users/friends.json'
    rescue #Mongoid::Errors::DocumentNotFound
      render 'api/v1/users/friends.json'
    end
  end
end