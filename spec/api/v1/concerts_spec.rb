require 'spec_helper'

describe "/api/v1/artists/:artist_id/concerts/past", type: :api, vcr: true do
  let(:url) { "/api/v1/artists/276130/concerts/past.json" } #276130 is AC/DC

  it "should return past concerts" do
    get url, {city: 'Toronto'}

    last_response.body
  end
end

describe "/api/v1/(artists/:artist_id/)concerts/future", type: :api, vcr: true do
  let(:url_artist) { "/api/v1/artists/3732956/concerts/future.json" } #276130 is One Direction
  let(:url_city) { "/api/v1/concerts/future.json" }

  it "should return future concerts (for an artist)" do
    get url_artist, {city: 'Toronto'}

    last_response.body
  end

  it "should return future concerts (for a city)" do
    get url_city, {city: 'Toronto'}

    last_response.body
  end
end

describe "/api/v1/users/:facebook_uuid/concerts", type: :api, vcr: false do
  let(:user) { FactoryGirl.create :user }
  let(:url) { "/api/v1/users/#{user.facebook_uuid}/concerts.json" }

  it "should add a concert to a user" do
    get url
    last_response.body.should == "{\"concerts\":[]}"

    post url, songkick_id: 14695959 # Taylor Swift in Toronto
    last_response.body.should == "{\"response\":\"success\"}"
    user.concerts.count.should == 1
  end
end if false # TODO: turn off for now