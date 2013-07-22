class Demo::EventsController < Demo::BaseController
  def index
    if params[:term]
      # SMELL same as combined_search
      search_results = Artist.search(params[:term])
      @artist = Artist.find_or_create_from_lastfm(search_results[0].lastfm_id)
      @others = search_results[1..-1]
      
      @events = @artist.past_events("Toronto")
    else
      @events = []
      @artist = nil
      @others = []
    end
  end

  def show
    @event = Event.find_or_create_from_lastfm(params[:id])
    @event.populate! #unless @event.populated?
  end
end