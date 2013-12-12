require 'spec_helper'
require 'lastfm_api'

describe Saver::PastEvents, :vcr do
  let(:artist) { Artist.find_or_create_from_lastfm("Justin Bieber") }

  it "should work for the sample" do
    Saver::PastEvents.new.perform(artist.lastfm_id)
  end
end