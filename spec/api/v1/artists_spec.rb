require 'spec_helper'

describe "/api/v1/artists/search?term=", :type => :api do
  let(:url) { "/api/v1/artists/search.json" }

  it "should return nothing for an empty term" do
    get url, term: nil

    last_response.body.should == "{\"artists\":[]}"
  end

  it "should return something for a term" do
    get url, term: "Radiohead"

    last_response.body.should == "{\"artists\":[{\"name\":\"Radiohead\",\"songkick_id\":253846}]}"
  end
end