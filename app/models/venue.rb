class Venue
  include Concerns::Lastfmable

  field :street, type: String
  field :postalcode, type: String
  # TODO: convert to using geocoder esp. for inaccurate locations
  field :latitude, type: Float
  field :longitude, type: Float

  has_many :events
  belongs_to :geo
  embeds_many :instagram_locations
  accepts_nested_attributes_for :instagram_locations # TODO: for RailsAdmin
end
