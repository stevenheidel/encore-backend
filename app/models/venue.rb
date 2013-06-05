# == Schema Information
#
# Table name: venues
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  latitude    :decimal(, )
#  longitude   :decimal(, )
#  created_at  :datetime
#  updated_at  :datetime
#  location    :string(255)
#  eventful_id :integer
#

class Venue < ActiveRecord::Base
  has_many :concerts
  has_many :instagram_locations
end
