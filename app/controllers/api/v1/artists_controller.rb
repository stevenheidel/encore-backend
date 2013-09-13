class Api::V1::ArtistsController < Api::V1::BaseController
  def search
    @artists = params[:term] ? Artist.search(params[:term]) : []
  end

  def combined_search
    search_results = Artist.search(params[:term])
    @artist = Artist.find_or_create_from_lastfm(search_results[0].lastfm_id)
    @others = search_results[1..-1]

    geo = Geo.new(params[:latitude], params[:longitude], params[:radius], request)
    
    case params[:tense]
    when "past"
      @events = @artist.past_events(geo)
    when "future"
      @events = @artist.future_events(geo)
    end
  end

  def picture
    @artist = Artist.find_or_create_from_lastfm(params[:id])
  end

  def info
    limit_events = params[:limit_events].to_i
    limit_events = 2 if limit_events<=0
    @artist = Artist.find_or_create_from_lastfm(params[:id])
    @past_events     = @artist.past_events(nil, {limit: limit_events})
    @upcoming_events = @artist.future_events(nil, {limit: limit_events})
  end
end