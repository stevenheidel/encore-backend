class Venue
  include Concerns::Lastfmable

  field :city, type: String
  field :country, type: String
  field :street, type: String
  field :postalcode, type: String
  field :coordinates, type: Array

  has_many :events
  embeds_many :instagram_locations
  accepts_nested_attributes_for :instagram_locations # TODO: for RailsAdmin

  index({coordinates: '2d'}, {min: -180, max: 180})
end