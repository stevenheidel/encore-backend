require 'spec_helper'
require 'lastfm_api'

describe Saver::Events, :vcr do
  it "should work for the sample" do
    Saver::Events.new.perform(LastfmAPI.event_getInfo(319963))

    Event.first.venue
    Venue.first.events.count
    Event.first.images.count
  end
end