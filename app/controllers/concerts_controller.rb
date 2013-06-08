require 'eventful_api'

class ConcertsController < ApplicationController
  def new
    if params[:concert_name].blank?
      @concerts = nil
    else
      @concerts = EventfulAPI.full_search(params[:concert_name], params[:city], params[:concert_date])
    end
  end

  def create
    e = EventfulAPI.get_event_by_id(params[:eventful_id])

    concert = Concert.new
    concert.name   = e.title
    concert.date   = e.start_time
    concert.start_time = DateTime.parse(e.start_time)
    if e.stop_time
      concert.end_time = DateTime.parse(e.stop_time)
    else
      # Arbitrarily add 6 hours from start time
      concert.end_time = concert.start_time + 6.hours
    end
    concert.eventful_id = e.id

    venue = Venue.new
    venue.name     = e.venue_name
    venue.location = e.city
    venue.latitude  = e.latitude
    venue.longitude = e.longitude
    venue.eventful_id = e.venue_id
    venue.save

    concert.venue = venue
    concert.save
    
    redirect_to concert
  end

  def show
    @concert = Concert.find(params[:id])
    ConcertPopulator.perform_async(@concert.id) unless @concert.populated
  end

  def populated
    render :text => Concert.find(params[:id]).populated
  end
end