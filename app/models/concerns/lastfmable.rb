require 'lastfm_api'

module Concerns::Lastfmable
  extend ActiveSupport::Concern

  included do
    has_many :images, class_name: "Other::LastfmImage", as: :lastfm_imageable

    validates_uniqueness_of :lastfm_id
  end

  module ClassMethods
    # Search for an entity by lastfm_id
    def get(lastfm_id)
      self.find_by(lastfm_id: lastfm_id)
    end

    # Like find_or_create_by but calls its corresponding info API call
    # Doesn't work for venues
    def find_or_create_from_lastfm(lastfm_id)
      object = self.get(lastfm_id)
      
      unless object
        # Doesn't exist yet so make it and populate it
        object = self.new
        object.lastfm_id = lastfm_id

        case self.name
        when "Event"
          lastfm_event = Lastfm::Event.new(LastfmAPI.event_getInfo(lastfm_id))
          object.update_from_lastfm(lastfm_event)

          venue_object = Venue.find_or_create_then_update_from_lastfm(lastfm_event.venue)
          object.venue = venue_object
        when "Artist"
          lastfm_artist = Lastfm::Artist.new(LastfmAPI.artist_getInfo(lastfm_id))
          object.update_from_lastfm(lastfm_artist)
        end
      end

      object.save!
      object
    end

    def find_or_create_then_update_from_lastfm(lastfm_object)
      object = self.find_or_initialize_by(lastfm_id: lastfm_object.lastfm_id)
      object.update_from_lastfm(lastfm_object)
      object
    end
  end

  # Update an object from its corresponding Lastfm:: class
  def update_from_lastfm(lastfm_object)
    # Create a hash with the name of the method and response to it
    params = {}
    lastfm_object.methods.each { |m| params[m] = lastfm_object.send(m) }

    self.update_attributes(params)

    # Find all the image tags and put them in embeds_many images
    self.images = lastfm_object.images.map do |image|
      Other::LastfmImage.new(size: image["size"], url: image["#text"])
    end

    self.save!
  end

  # Get the largest of the images
  def image_url
    %w[small medium large extralarge mega].reverse.each do |size|
      query = self.images.where(size: size)
      return query.first.url if query.exists?
    end
    return "TODO: default image for events without images"
  end
end