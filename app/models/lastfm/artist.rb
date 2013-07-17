class Lastfm::Artist < Lastfm::Base
  def methods
    super + [:mbid] - [:website]
  end

  # For artist, the name string is also the unique ID
  def lastfm_id
    name
  end

  def website
    raise "Lastfm::Artist JSON has no website"
  end

  def mbid
    @json["mbid"]
  end
end