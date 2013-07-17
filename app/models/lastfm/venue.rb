class Lastfm::Venue < Lastfm::Base
  def methods
    super + [:city, :country, :street, :postalcode, :coordinates]
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
    # MongoDB stores coordinates with longitude first
    [ @json["location"]["geo:point"]["geo:long"], 
      @json["location"]["geo:point"]["geo:lat"] ].map do |l|
      l.to_f
    end
  end

  # Check if venue is within a particular radius from a point
  # Point should be [long, lat] and radius is in miles
  def in_radius?(point, radius)
    Geocoder::Calculations.distance_between(
      point.reverse, self.coordinates.reverse) < radius
  end
end