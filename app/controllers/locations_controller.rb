class LocationsController < ApplicationController
  def index
    if params[:latitude] && params[:longitude]
      @instagram_locations = InstagramLocation.search(params[:latitude], params[:longitude])
    else
      @instagram_locations = []
    end
  end
end
