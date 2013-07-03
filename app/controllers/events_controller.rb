class EventsController < ApplicationController
  def show
    @event = Event.get(params[:id])
  end
end