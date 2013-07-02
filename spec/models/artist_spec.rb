require 'spec_helper'

describe Artist, :vcr do
  let(:artist) { FactoryGirl.create :artist }

  describe ".past_events" do
    it "should call API for past events" do
      artist.past_events("Toronto").count.should == 224
    end
  end
end