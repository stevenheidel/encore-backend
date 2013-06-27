class ConcertsController < ApplicationController
  def show
    @concert = Concert.find_by(songkick_uuid: params[:id])
    @posts = @concert.posts
  end
end