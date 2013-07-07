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

    embeds_many :images, class_name: "Lastfm::Image"
    accepts_nested_attributes_for :images # TODO: for RailsAdmin

    validates_uniqueness_of :lastfm_id
  end

  module ClassMethods
    # Search for an entity by lastfm_id
    def get(lastfm_id)
      self.find_or_create_by(lastfm_id: lastfm_id)
    end
  end

  # Update an object from its corresponding Lastfm:: class
  def update_from_lastfm(lastfm_object)
    # Create a hash with the name of the method and response to it
    params = {}
    lastfm_object.methods.each { |m| params[m] = lastfm_object.send(m) }

    self.update_attributes(params)

    # Find all the image tags and put them in embeds_many images
    # TODO: this also causes a lot of errors in Sidekiq
    lastfm_object.images.each do |image|
      self.images.find_or_create_by(size: image["size"], url: image["#text"])
    end
  end
end