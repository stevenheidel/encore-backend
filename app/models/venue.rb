class Venue
  include Mongoid::Document
  include Mongoid::Timestamps

  include Lastfmable

  field :city, type: String
  field :country, type: String
  # TODO: convert to using geocoder esp. for inaccurate locations
  field :latitude, type: Float
  field :longitude, type: Float

  has_many :events
  has_many :instagram_locations

  def fill(response=nil)
    # TODO there is no venue.getInfo

    self.city = response.location.city
    self.country = response.location.country
    self.latitude = response.location["geo:point"]["geo:lat"]
    self.longitude = response.location["geo:point"]["geo:long"]

    fill_defaults(response)
  end
end
