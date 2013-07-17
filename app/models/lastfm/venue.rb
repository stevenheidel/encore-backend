class Lastfm::Venue < Lastfm::Base
  def methods
    super + [:city, :country, :street, :postalcode, :coordinates]
  end

  def city
    @json["location"]["city"] rescue nil # TODO: sometimes events don't have venues?
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
end