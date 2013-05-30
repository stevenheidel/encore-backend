class LocationsController < ApplicationController
  def index
    if params[:latitude].blank? || params[:longitude].blank?
      @instagram_locations = []
    else
      @instagram_locations = InstagramLocation.search(params[:latitude], params[:longitude])
    end
  end
end
