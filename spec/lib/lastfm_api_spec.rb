require 'lastfm_api'
require 'spec_helper'

describe LastfmAPI, :vcr do
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

    it "should always return an array" do
      lastfm_response = LastfmAPI.artist_getPastEvents_all("some non-musician")
      lastfm_response.is_a?(Array).should be_true
      lastfm_response.length.should == 0

      lastfm_response = LastfmAPI.artist_getPastEvents_all("Streetlight Manifesto", 1)
      lastfm_response.is_a?(Array).should be_true
      lastfm_response.length.should == 1
    end
  end

  describe "artist.getEvents_all" do
    it "should retrieve all upcoming events" do
      lastfm_response = LastfmAPI.artist_getEvents_all("Streetlight Manifesto")
      lastfm_response.size.should == 22
    end

    it "should retrieve a limited amount of upcoming events" do
      lastfm_response = LastfmAPI.artist_getEvents_all("Streetlight Manifesto", {page: 2, limit: 10})
      
      lastfm_response.size.should == 10
      lastfm_response.first['startDate'].should                 == "Fri, 01 Nov 2013 20:00:00"
      lastfm_response.first['venue']['location']['city'].should == "Dallas"
      lastfm_response[3]['startDate'].should                    == "Wed, 06 Nov 2013 19:30:00"
      lastfm_response[3]['venue']['location']['city'].should    == "Fort Lauderdale"
    end

    it "should always return an array" do
      lastfm_response = LastfmAPI.artist_getEvents_all("some non-musician")
      lastfm_response.is_a?(Array).should be_true
      lastfm_response.length.should == 0

      lastfm_response = LastfmAPI.artist_getEvents_all("Streetlight Manifesto", {limit: 1})
      lastfm_response.is_a?(Array).should be_true
      lastfm_response.length.should == 1
    end
  end

  describe "artist.artist_search" do
    it "should return an array, no matter the amount of artists found" do
      lastfm_response = LastfmAPI.artist_search("rolling")
      lastfm_response.is_a?(Array).should be_true
      lastfm_response.length.should == 30
      lastfm_response[2]["name"].should == "Las 100 Canciones Mas Rolling"
      lastfm_response[6]["name"].should == "Rolling in the Deep"

      lastfm_response = LastfmAPI.artist_search("ROLLING STONEA")
      lastfm_response.is_a?(Array).should be_true
      lastfm_response.length.should == 1
      lastfm_response[0]["url"].should == "http://www.last.fm/music/Rolling+Stonea"

      lastfm_response = LastfmAPI.artist_search("a plumber dude ain't a musician")
      lastfm_response.is_a?(Array).should be_true
      lastfm_response.length.should == 0
    end
  end
end