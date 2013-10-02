# == Schema Information
#
# Table name: venues
#
#  id         :uuid             not null, primary key
#  lastfm_id  :string(255)
#  name       :string(255)
#  website    :string(255)
#  url        :string(255)
#  city       :string(255)
#  country    :string(255)
#  street     :string(255)
#  postalcode :string(255)
#  created_at :datetime
#  updated_at :datetime
#  latitude   :float
#  longitude  :float
#

class Venue < ActiveRecord::Base
  include Concerns::Lastfmable

  reverse_geocoded_by :latitude, :longitude

  has_many :events
  has_many :instagram_locations, class_name: "Other::InstagramLocation"

  validates_presence_of :name
  validate :validate_coordinates

  def coordinates
    [latitude, longitude]
  end

  private
  def validate_coordinates
    invalid_coordinates = []

    if (self.longitude.nil? and self.latitude.present?) or
       (self.latitude.nil? and self.longitude.present?)
      invalid_coordinates = [true]
    end

    if(self.longitude.present? and self.latitude.present?)
      invalid_coordinates = [self.latitude, self.longitude].map{ |coordinate|
        coordinate.is_a? Numeric or
        (coordinate.is_a? String and (coordinate.strip =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/) == 0)
      }.select{ |e| e == false }
    end
    errors.add(:coordinates, "Coordinates are not numeric") unless invalid_coordinates.empty?
  end
end
