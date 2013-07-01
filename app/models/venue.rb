# == Schema Information
#
# Table name: venues
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  latitude      :decimal(10, 6)
#  longitude     :decimal(10, 6)
#  created_at    :datetime
#  updated_at    :datetime
#  location      :string(255)
#  songkick_uuid :integer
#

class Venue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :latitude, type: Float
  field :longitude, type: Float
  field :location, type: String 
  field :songkick_uuid, type: Integer

  has_many :concerts
  has_many :instagram_locations
end
