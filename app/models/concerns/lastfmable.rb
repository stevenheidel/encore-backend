require 'lastfm_api'

module Concerns::Lastfmable
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps

    field :lastfm_id, type: String
    field :name, type: String
    field :website, type: String
    field :url, type: String

    has_many :images, class_name: "Other::LastfmImage", as: :lastfm_imageable
    accepts_nested_attributes_for :images # for RailsAdmin

    index({lastfm_id: 1}, {unique: true})

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
      begin
        self.get(lastfm_id)
      rescue Mongoid::Errors::DocumentNotFound
        # Doesn't exist yet so make it and populate it
        object = self.new
        object.lastfm_id = lastfm_id

        case self.name
        when "Event"
          lastfm_json = LastfmAPI.event_getInfo(lastfm_id)
          Saver::Events.new.perform(lastfm_json)
          object = self.get(lastfm_id)
        when "Artist"
          lastfm_object = Lastfm::Artist.new(LastfmAPI.artist_getInfo(lastfm_id))
          object.update_from_lastfm(lastfm_object)
        end
        
        object
      end
    end
  end

  # Update an object from its corresponding Lastfm:: class
  def update_from_lastfm(lastfm_object)
    # Create a hash with the name of the method and response to it
    params = {}
    lastfm_object.methods.each { |m| params[m] = lastfm_object.send(m) }

    self.update_attributes(params)
    self.save!

    # Find all the image tags and put them in embeds_many images
    # TODO: this also causes a lot of errors in Sidekiq
    lastfm_object.images.each do |image|
      self.images.find_or_create_by(size: image["size"], url: image["#text"])
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