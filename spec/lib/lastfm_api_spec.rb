require 'lastfm_api'
require 'spec_helper'

describe LastfmAPI, vcr: { record: :once, re_record_interval: nil } do
  describe "artist.getPastEvents_all" do
    it "should retrieve all past events" do
      lastfm_response = LastfmAPI.artist_getPastEvents_all("Streetlight Manifesto")
      lastfm_response.size.should == 679
    end

    it "should retrieve a limited amount of recent past events" do
      lastfm_response = LastfmAPI.artist_getPastEvents_all("Streetlight Manifesto", 10)
      
      lastfm_response.size.should == 10
      lastfm_response.first['startDate'].should == "Sat, 13 Jul 2013 19:00:00"
      lastfm_response.last['startDate'].should  == "Wed, 26 Jun 2013 19:00:00"
    end
  end

  describe "artist.getEvents_all" do
    it "should retrieve all upcoming events" do
      lastfm_response = LastfmAPI.artist_getEvents_all("Streetlight Manifesto")
      lastfm_response.size.should == 22
    end

    it "should retrieve a limited amount of upcoming events" do
      lastfm_response = LastfmAPI.artist_getEvents_all("Streetlight Manifesto", 10)
      
      lastfm_response.size.should == 10
      lastfm_response.first['startDate'].should                 == "Tue, 01 Oct 2013 19:00:00"
      lastfm_response.first['venue']['location']['city'].should == "New York"
      lastfm_response[3]['startDate'].should                    == "Sat, 05 Oct 2013 19:00:00"
      lastfm_response[3]['venue']['name'].should                == "Métropolis"
      lastfm_response[3]['venue']['location']['country'].should == "Canada"
    end
  end
end