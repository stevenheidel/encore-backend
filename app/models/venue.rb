class Venue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :latitude, type: Float
  field :longitude, type: Float
  field :location, type: String 
  field :songkick_uuid, type: Integer

  has_many :concerts
  has_many :instagram_locations
end
