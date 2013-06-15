require 'songkick_api'

class ConcertsController < ApplicationController
  def new
    unless params[:concert_name].blank?
      @concerts = SongkickAPI.full_search(params[:concert_name], params[:concert_date], params[:city])
    end
  end

  def create
    e = SongkickAPI.get_event_by_id(params[:songkick_id])

    concert = Concert.new
    concert.name   = e.displayName
    concert.date   = e.start.date
    if e.start.time
      concert.start_time = DateTime.parse(e.start.date + "T" + e.start.time)
    else
      # TODO: Arbitrarily choose 6:00 as starting time
      concert.start_time = DateTime.parse(e.start.date + "T" + "18:00:00")
    end
    # TODO: Arbitrarily add 6 hours from start time
    concert.end_time = concert.start_time + 6.hours
    concert.songkick_uuid = e.id.to_i

    venue = Venue.where(songkick_uuid: e.venue.id.to_i).first_or_initialize
    venue.name     = e.venue.displayName
    venue.location = e.location.city
    venue.latitude  = e.location.lat
    venue.longitude = e.location.lng
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