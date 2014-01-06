# == Schema Information
#
# Table name: venues
#
#  id         :uuid             not null, primary key
#  lastfm_id  :string(255)
#  name       :string(255)
#  website    :text
#  url        :string(255)
#  city       :string(255)
#  country    :string(255)
#  street     :string(255)
#  postalcode :string(255)
#  created_at :datetime
#  updated_at :datetime
#  latitude   :float
#  longitude  :float
#

class Lastfm::Venue < Lastfm::Base
  def methods
    super + [:city, :country, :street, :postalcode, :latitude, :longitude]
  end

  def city
    @json["location"]["city"]
  end

  def country
    @json["location"]["country"]
  end

  def street
    @json["location"]["street"]
  end

  def postalcode
    @json["location"]["postalcode"]
  end

  def coordinates
    [self.latitude, self.longitude]
  end

  def latitude
    @json["location"]["geo:point"]["geo:lat"].to_f
  end

  def longitude
    @json["location"]["geo:point"]["geo:long"].to_f
  end

  # Check if venue is within a particular radius from a point
  # Point should be [long, lat] and radius is in miles
  def in_radius?(geo)
    Geocoder::Calculations.distance_between(
      geo.point, self.coordinates) < geo.radius
  end
end
