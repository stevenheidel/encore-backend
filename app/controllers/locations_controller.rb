require 'instagram_api'

class LocationsController < ApplicationController
  def index
    if params[:latitude].blank? || params[:longitude].blank?
      @instagram_locations = []
    else
      @instagram_locations = InstagramAPI.location_search(params[:latitude], params[:longitude])
    end
  end
end
