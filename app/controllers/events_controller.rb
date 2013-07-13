class EventsController < ApplicationController
  def show
    @event = Event.find_or_create_from_lastfm(params[:id])
    @posts = @event.posts
  end
end