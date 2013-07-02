class Venue
  include Lastfmable

  field :street, type: String
  field :postalcode, type: String
  # TODO: convert to using geocoder esp. for inaccurate locations
  field :latitude, type: Float
  field :longitude, type: Float

  has_many :events
  belongs_to :geo
  embeds_many :instagram_locations

  def fill(response=nil)
    # TODO there is no venue.getInfo

    fill_defaults(response)

    # Associate with geo
    self.geo = Geo.get_or_set(response.location.city, response.location.country)

    self.street = response.location.street
    self.postalcode = response.location.postalcode
    self.latitude = response.location["geo:point"]["geo:lat"]
    self.longitude = response.location["geo:point"]["geo:long"]
  end
end
