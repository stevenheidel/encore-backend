require 'spec_helper'
require 'lastfm_api'

describe Saver::Events, :vcr do
  it "should work for the sample" do
    Saver::Events.new.perform(LastfmAPI.event_getInfo(319963))

    pp Event.first.venue
    pp Venue.first.events.count
    pp Event.first.images.count
    pp Event.first.venue.geo
  end
end