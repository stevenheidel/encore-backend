class Venue
  include Concerns::Lastfmable

  field :city, type: String
  field :country, type: String
  field :street, type: String
  field :postalcode, type: String
  field :coordinates, type: Array, default: [nil, nil]

  has_many :events
  embeds_many :instagram_locations
  accepts_nested_attributes_for :instagram_locations # TODO: for RailsAdmin

  index({coordinates: '2dsphere'}, {min: -180, max: 180})

  def latitude
    self.coordinates[1]
  end

  def longitude
    self.coordinates[0]
  end

  def latitude=(num)
    self.coordinates[1] = num
  end

  def longitude=(num)
    self.coordinates[0] = num
  end
end