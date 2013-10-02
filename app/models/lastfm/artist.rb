# == Schema Information
#
# Table name: artists
#
#  id         :uuid             not null, primary key
#  lastfm_id  :string(255)
#  name       :string(255)
#  website    :string(255)
#  url        :string(255)
#  mbid       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

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
