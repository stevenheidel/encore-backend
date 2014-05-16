# == Schema Information
#
# Table name: artists
#
#  id                   :uuid             not null, primary key
#  lastfm_id            :string(255)
#  name                 :string(255)
#  website              :text
#  url                  :string(255)
#  mbid                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  past_event_freshness :datetime
#

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
      Saver::PastEvents.drain # run the cache creator
      Saver::UpdateEvent.drain
      artist.reload
      database_events = artist.past_events(geo)

      lastfm_events.count.should == database_events.count
    end

    it "should retrieve past events not limited by coordinates" do
      artist.past_events.count.should == 225
    end

    it "should retrieve a limited amount of past events" do
      artist.past_events(nil, {limit: 5}).count.should == 5
    end
  end

  describe ".future_events" do
    it "should retrieve future events not limited by coordinates" do
      artist = FactoryGirl.create :streetlight_manifesto
      artist.future_events.count.should == 22
    end

    it "should retrieve a limited amount of upcoming events" do
      artist = FactoryGirl.create :streetlight_manifesto
      events = artist.future_events(nil, {page: 2, limit: 10})
      events.count.should == 10
      events[0].start_date.should == "Fri, 01 Nov 2013 20:00:00"
      events[3].start_date.should == "Wed, 06 Nov 2013 19:30:00"
    end
  end
end
