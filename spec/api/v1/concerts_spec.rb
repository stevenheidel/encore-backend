require 'spec_helper'

describe "/api/v1/artists/:artist_id/concerts/past", type: :api, vcr: true do
  let(:url) { "/api/v1/artists/276130/concerts/past.json" } #276130 is AC/DC

  it "should return past concerts" do
    get url, {city: 'Toronto'}

    last_response.body
  end
end

describe "/api/v1/users/:facebook_uuid/concerts", type: :api, vcr: true do
  let(:user) { FactoryGirl.create :user }
  let(:url) { "/api/v1/users/#{user.facebook_uuid}/concerts.json" }

  it "should add a concert to a user" do
    get url
    last_response.body.should == "{\"concerts\":[]}"

    post url, songkick_id: 14695959 # Taylor Swift in Toronto
    last_response.body.should == "{\"response\":\"success\"}"
    user.concerts.count.should == 1
  end
end