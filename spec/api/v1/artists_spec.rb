require 'spec_helper'

describe Api::V1::ArtistsController, :vcr do
  describe "/api/v1/artists/search?term=", :type => :api do
    let(:url) { "/api/v1/artists/search.json" }

    it "should return nothing for an empty term" do
      get url, term: nil

      last_response.body.should == "{\"artists\":[]}"
    end

    it "should return something for a term" do
      get url, term: "Radiohead"

      last_response.body.should_not == "{\"artists\":[]}"
    end
  end

  describe "/api/v1/artists/combined_search?term=", :type => :api do
    let(:url) { "/api/v1/artists/combined_search.json" }

    it "should return nothing for an empty term" do
      get url, term: nil

      last_response.body.should == "{\"artist\":{},\"others\":[],\"events\":[]}"
    end

    it "should return something for a term" do
      get url, { "latitude"=>"41.88322", "longitude"=>"-87.63243", "radius"=>"0.5", "tense"=>"future", "term"=>"Streetlight Manifesto" }

      last_response.body.should_not == "{\"artists\":[]}"
    end
  end
end