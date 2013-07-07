class Lastfm::Venue < Lastfm::Base
  def methods
    super + [:street, :postalcode, :latitude, :longitude]
  end

  def street
    @json["location"]["street"]
  end

  def postalcode
    @json["location"]["postalcode"]
  end

  def latitude
    @json["location"]["geo:point"]["geo:lat"]
  end

  def longitude
    @json["location"]["geo:point"]["geo:long"]
  end

  # City and country come from lastfm in venue but stored in database as Geo
  def city
    @json["location"]["city"]
  end

  def country
    @json["location"]["country"]
  end
end