class Api::V1::ArtistsController < Api::V1::BaseController
  def search
    @artists = Artist.search(params[:term])
  end
end