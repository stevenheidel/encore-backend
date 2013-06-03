# == Schema Information
#
# Table name: instagram_locations
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  venue_id   :integer
#

require 'instagram_api'

class InstagramLocation < ActiveRecord::Base
  belongs_to :venue

  # TODO: should send a venue
  def self.search(latitude, longitude)
    InstagramAPI.location_search(latitude, longitude)
  end

  # TODO: Pass through for now, switch to instance method later
  def self.recent_media(location_id, min_timestamp, max_timestamp)
    InstagramAPI.location_recent_media(location_id, min_timestamp, max_timestamp)
  end
end
