require 'spec_helper'

describe Event, :vcr do
  let(:event) { FactoryGirl.create :event }

  describe "#get" do
    it "should return an event if it exists" do
      Event.get(event.lastfm_id).should == event
    end

    it "should retrieve a concert if it doesn't exist" do
      e = Event.get!(2011881)

      e.name.should == "Salvationz Outdoor"
      e.images.size.should == 4
      e.venue.name.should == "E3 strand"
      e.venue.images.size.should == 5
      e.artists.size.should == 82
    end
  end

  describe ".fill" do
    # TODO: should test the fill method here not up there
  end
end