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
      self.find_by(lastfm_id: lastfm_id.to_s)
    end

    # Like find_or_create_by but calls its corresponding info API call
    # Doesn't work for venues
    def find_or_create_from_lastfm(lastfm_id, lastfm_object=nil)
      object = self.get(lastfm_id)
      
      if lastfm_object || object.nil?
        # Doesn't exist yet so make it and populate it
        object = self.new if object.nil?
        object.lastfm_id = lastfm_id

        case self.name
        when "Event"
          lastfm_event = lastfm_object || Lastfm::Event.new(LastfmAPI.event_getInfo(lastfm_id))
          object.update_from_lastfm(lastfm_event)

          venue_object = Venue.find_or_create_by(lastfm_id: lastfm_event.venue.lastfm_id).update_from_lastfm(lastfm_event.venue)
          object.venue = venue_object

          # Get all the artists
          lastfm_event.artists.each do |artist|
            object.artists << Artist.find_or_create_from_lastfm(artist)
          end
        when "Artist"
          lastfm_artist = lastfm_object || Lastfm::Artist.new(LastfmAPI.artist_getInfo(lastfm_id))
          object.update_from_lastfm(lastfm_artist)
        end
      end

      object.save
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
    self.image_url_cached = lastfm_object.image_url

    self
  end

  def image_url
    self.update(image_url_cached: get_image_url) unless self.image_url_cached

    self.image_url_cached
  end

  # Get the largest of the images
  def get_image_url
    %w[small medium large extralarge mega].reverse.each do |size|
      query = self.images.where(size: size)
      return query.first.url if query.exists?
    end
    return "http://on.encore.fm/assets/public/applogo.png"
  end
end