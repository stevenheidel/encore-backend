require 'will_paginate/array'

class Public::EventsController < Public::BaseController
  def show
    @event = Event.find_or_create_from_lastfm(params[:id])
    @posts = @event.posts.shuffle(random: Random.new(1)).paginate(:page => params[:page], :per_page => 21)
  end
end