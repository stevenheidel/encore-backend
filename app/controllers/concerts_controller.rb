require 'songkick_api'

class ConcertsController < ApplicationController
  def show
    if @concert = Concert.find_by(songkick_uuid: params[:id])
      @posts = @concert.posts
    else
      @concert = SongkickAPI.get_event_by_id(params[:id])
    end
  end
end