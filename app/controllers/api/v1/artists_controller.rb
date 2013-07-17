class Api::V1::ArtistsController < Api::V1::BaseController
  def search
    @artists = params[:term] ? Artist.search(params[:term]) : []
  end

  def combined_search
    search_results = Artist.search(params[:term])
    @artist = Artist.find_or_create_from_lastfm(search_results[0].lastfm_id)
    @others = search_results[1..-1]
    
    case params[:tense]
    when "past"
      @events = @artist.past_events(params[:city])
    when "future"
      @events = @artist.future_events(params[:city])
    end
  end
end