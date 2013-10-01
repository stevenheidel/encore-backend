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

  describe "picture", :type => :api do
    it "should allow special characters in the artist id" do
      get "/api/v1/artists/picture.json?artist_id=What%20Cheer?%20Brigade"
      response = JSON.parse(last_response.body)
      response["image_url"].should == "http://userserve-ak.last.fm/serve/500/70112782/What+Cheer+Brigade+whatcheer.jpg"

      get "/api/v1/artists/picture.json?artist_id=Jenny%20O."
      response = JSON.parse(last_response.body)
      response["image_url"].should == "http://userserve-ak.last.fm/serve/500/68616562/Jenny+O+jennyo2.jpg"

      get "/api/v1/artists/picture.json?artist_id=Mary%20J.%20Blige"
      response = JSON.parse(last_response.body)
      response["image_url"].should == "http://userserve-ak.last.fm/serve/_/49215123/Mary+J+Blige.png"
    end
  end
  

  describe "info", :type => :api do
    let(:url) { "/api/v1/artists/info.json?artist_id=Imagine%20Dragons&limit_events=1" }

    it "should return short info on Artist with a handful of events" do
      get url
      response = JSON.parse(last_response.body)
      response["name"].should == "Imagine Dragons"
      response["events"]["past"].length.should == 1
      response["events"]["upcoming"].length.should == 1
    end
  end
end