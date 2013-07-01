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

describe "/api/v1/users/:facebook_uuid/concerts", type: :api, vcr: true do
  let(:concert) { FactoryGirl.create :concert }
  let(:user) { FactoryGirl.create :user }
  let(:url) { "/api/v1/users/#{user.facebook_uuid}/concerts.json" }

  it "should add a concert to a user" do
    get url
    last_response.body.should == "{\"concerts\":{\"past\":[],\"future\":[]}}"

    post url, songkick_id: 14695959 # Taylor Swift in Toronto
    last_response.body.should == "{\"response\":\"success\"}"
    
    user.reload
    user.concerts.count.should == 1
    user.concerts.first.name.should == "Taylor Swift"

    ConcertPopulator.jobs.size.should == 1
  end

  it "should check if the user has that concert" do
    user.concerts << concert

    get url, songkick_id: concert.songkick_uuid
    last_response.body.should == "{\"response\":true}"

    get url, songkick_id: 12345
    last_response.body.should == "{\"response\":false}"
  end
end

describe "/api/v1/users/:facebook_uuid/concerts/:id", type: :api, vcr: true do
  let(:concert) { FactoryGirl.create :concert }
  let(:user) { FactoryGirl.create :user }
  let(:url) { "/api/v1/users/#{user.facebook_uuid}/concerts/#{concert.songkick_uuid}.json" }

  it "should delete a concert from the user's concerts" do
    user.concerts << concert

    delete url

    user.reload
    user.concerts.count.should == 0
  end
end