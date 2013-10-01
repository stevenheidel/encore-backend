require 'spec_helper'

describe Api::V1::ArtistsController, :vcr do
  describe "/api/v1/artists/search?term=", :type => :api do
    let(:url) { "/api/v1/artists/search.json" }

    it "should return search results" do
      get url, term: nil
      last_response.body.should == "{\"artists\":[]}"

      get url, term: "Radiohead"
      last_response.body.should_not == "{\"artists\":[]}"
    end
  end

  describe "/api/v1/artists/combined_search?term=", :type => :api do
    let(:url) { "/api/v1/artists/combined_search.json" }

    it "should return combined search results" do
      get url, term: nil
      last_response.body.should == "{\"artist\":{},\"others\":[],\"events\":[]}"

      get url, { "latitude"=>"41.88322", "longitude"=>"-87.63243", "radius"=>"0.5", "tense"=>"future", "term"=>"Streetlight Manifesto" }
      last_response.body.should_not == "{\"artists\":[]}"
    end
  end

  describe "info", :type => :api do
    let(:url) { "/api/v1/artists/Death%20Cab%20for%20Cutie/info.json?limit_events=1" }

    it "should return short info on Artist with a handful of events" do
      get url
      last_response.body.should_not == "{\"artists\":[]}"
    end
  end
end