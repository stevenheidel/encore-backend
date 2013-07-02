require 'lastfm_api'

module Lastfmable
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps

    field :lastfm_id, type: String
    field :name, type: String
    field :url, type: String

    embeds_many :images, class_name: "Lastfm::Image"

    validates_uniqueness_of :lastfm_id
  end

  module ClassMethods
    # Search for an entity but don't fill from API
    def get(lastfm_id)
      self.find_by(lastfm_id: lastfm_id)
    end

    # Search for an entity by the lastfm_id, fill from the API if needed
    def get!(lastfm_id)
      search = self.where(lastfm_id: lastfm_id)

      if search.exists?
        search.first
      else
        entity = self.new
        entity.lastfm_id = lastfm_id

        entity.fill
        entity.save

        entity
      end
    end

    # Search for an entity by the response.id, fill from the response if needed
    def get_or_set(response)
      entity = self.find_or_create_by(lastfm_id: response.id)
      entity.fill(response)
      entity.save

      entity
    end
  end

  # Fill the default fields that come with all lastfm entities
  def fill_defaults(response)
    self.lastfm_id = response.id
    self.name = response.name
    self.url = response.url

    fill_images(response)
  end

  # Find all the image tags and put them in embeds_many images
  def fill_images(response)
    response.image.each do |image|
      self.images << Lastfm::Image.new({size: image["size"], url: image["#text"]})
    end
  end
end