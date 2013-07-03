class Demo::EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.get(params[:id])
  end
end