require 'spec_helper'

describe Artist, :vcr do
  let(:artist) { FactoryGirl.create :artist }
  let(:latitude) { 43.670906 }
  let(:longitude) { -79.393331 }
  let(:geo) { Geo.new(latitude, longitude) }

  describe ".past_events" do
    it "should get past events from lastfm" do
      artist.past_events(geo).count.should == 1
    end

    it "should get past events from database" do
      lastfm_events = artist.past_events(geo)
      Saver::Events.drain # run the cache creator
      artist.reload
      database_events = artist.past_events(geo)

      lastfm_events.count.should == database_events.count
    end
  end
end