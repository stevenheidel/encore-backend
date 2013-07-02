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
      # Populate the event
      ConcertPopulator.perform_async(event.id.to_s)

      user.events << event

      render 'api/v1/base/result.json', locals: {result: 'success'}
    end
  end

  def past
    if params[:artist_id] # get past for artist
      @events = Artist.get(params[:artist_id]).past_events(params[:city])
    else # get popular past for city
      @events = []
    end

    render 'api/v1/events/index.json'
  end

  def future
    if params[:artist_id] # get future for artist
      @events = SongkickAPI.artist_upcoming_city(params[:artist_id], params[:city])
    else # get popular future for city
      location = SongkickAPI.location_search(params[:city]).first.metroArea.id
      @events = SongkickAPI.metroarea_upcoming(location)

      # IMPORTANT TODO: Deal with festivals
      @events.delete_if {|c| c.type == "Festival"}

      # don't include today's events
      @events.delete_if {|c| c.start.date == Date.today.strftime("%F")}
    end

    render 'api/v1/events/index.json'
  end

  def today
    # Get today's events from Songkick
    location = SongkickAPI.location_search(params[:city]).first.metroArea.id
    @events = SongkickAPI.metroarea_upcoming(location)

    @events.delete_if {|c| c.type == "Festival"}

    @events.keep_if {|c| c.start.date == Date.today.strftime("%F")}

    # TODO: WTF is wrong with today view?
    # @events = event.where("date = ?", Date.today).includes(:venue)
    # render 'api/v1/events/database.json'

    render 'api/v1/events/index.json'
  end

  def destroy
    event = Event.get(params[:id])
    user = User.get(params[:user_id])
    user.events.delete(event)

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end
end