# == Schema Information
#
# Table name: instagram_locations
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class InstagramLocation < ActiveRecord::Base
  def self.search(latitude, longitude)
    InstagramAPI.instagram_locations(latitude, longitude)
  end
end
