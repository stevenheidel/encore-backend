require 'echonest_api'
require 'songkick_api'

class Api::V1::ArtistsController < Api::V1::BaseController
  def search
    if params[:term]
      @artists = SongkickAPI.artist_search(params[:term])
      @artists.each{|a| a.name = a.displayName}
    end
  end
end