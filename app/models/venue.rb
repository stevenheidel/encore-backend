class Venue
  include Mongoid::Document
  include Mongoid::Timestamps

  include Lastfmable

  has_many :events
  has_many :instagram_locations

  def fill(response = nil)
    # TODO there is no venue.getInfo

    fill_defaults(response)
  end
end
