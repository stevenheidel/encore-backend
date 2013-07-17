require 'spec_helper'

describe Artist, :vcr do
  let(:artist) { FactoryGirl.create :artist }

  describe ".past_events" do
    it "should call API for past events" do
      artist.past_events("Toronto").count.should == 1
      artist.past_events("Las Vegas").first.venue.images.count.should == 5
    end
  end
end