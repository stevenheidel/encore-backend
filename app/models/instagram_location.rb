class InstagramLocation < ActiveRecord::Base
  include Instagramable

  def self.search(latitude, longitude)
    instagram_locations(latitude, longitude)
  end
end