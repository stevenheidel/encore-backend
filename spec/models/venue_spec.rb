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

require 'spec_helper'

describe Venue do
  it "should have name" do
    venue = FactoryGirl.build :venue
    venue.name = nil
    saved = venue.save
    saved.should be_false
    venue.errors[:name].should_not be_empty

    venue.name = "Metropolis"
    saved = venue.save
    saved.should be_true
    venue.errors[:name].should be_empty
  end

  pending "should have numeric coordinates" do
    venue = FactoryGirl.build :venue
    venue.longitude = -79.379305
    venue.latitude = 43.643929
    saved = venue.save
    saved.should be_true
    venue.errors[:coordinates].should be_empty

    venue.latitude = "43.643929"
    venue.longitude = "-79.379305"
    saved = venue.save
    saved.should be_true
    venue.errors[:coordinates].should be_empty

    venue.latitude = nil
    venue.longitude = nil
    saved = venue.save
    saved.should be_true
    venue.errors[:coordinates].should be_empty

    venue.latitude = "43.643929"
    venue.longitude = nil
    saved = venue.save
    saved.should be_false
    venue.errors[:coordinates].should_not be_empty

    venue.latitude = "43.643929"
    venue.longitude = "x"
    saved = venue.save
    saved.should be_false
    venue.errors[:coordinates].should_not be_empty
  end
end
