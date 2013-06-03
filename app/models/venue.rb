# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  latitude   :decimal(, )
#  longitude  :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#  location   :string(255)
#

class Venue < ActiveRecord::Base
  has_many :concerts
  has_many :instagram_locations

  after_commit :location_from_eventful

  private

  def location_from_eventful
    return if self.latitude or self.longitude

    EventfulFiller.perform_async(:venue, self.id)
  end
end
