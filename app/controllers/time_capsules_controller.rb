class TimeCapsulesController < ApplicationController
  def new
  end

  def create
    # TODO: could DRY up using fields_for in view
    time_capsule = TimeCapsule.new

    concert = Concert.new
    concert.name   = params[:concert_name]
    concert.date   = params[:concert_date]

    venue = Venue.new
    venue.name     = params[:venue_name]
    venue.location = params[:venue_location]
    venue.save

    concert.venue = venue
    concert.save

    time_capsule.concert = concert
    time_capsule.save
    
    redirect_to time_capsule
  end

  def show
    @time_capsule = TimeCapsule.find(params[:id])
    ConcertPopulator.perform_async(@time_capsule.concert.id)
  end
end