require 'spec_helper'

describe "/api/v1/artists/:artist_id/events/past", type: :api, vcr: true do
  let(:artist) { FactoryGirl.create :artist }
  let(:url) { "/api/v1/artists/#{artist.lastfm_id}/events/past.json" }

  it "should return past events" do
    get url, {city: 'Toronto'}
    last_response.body.should == "{\"events\":[{\"lastfm_id\":\"206280\",\"name\":\"Cher\",\"date\":\"2002-10-24\",\"venue_name\":\"Air Canada Centre\"}]}"
  end
end

describe "/api/v1/(artists/:artist_id/)events/future", type: :api, vcr: true do
  let(:url_artist) { "/api/v1/artists/One+Direction/events/future.json" }
  let(:url_city) { "/api/v1/events/future.json" }

  it "should return future events (for an artist)" do
    get url_artist, {city: 'Toronto'}

    last_response.body
  end

  it "should return future events (for a city)" do
    get url_city, {city: 'Toronto'}

    last_response.body
  end
end

describe "/api/v1/users/:facebook_id/events", type: :api, vcr: true do
  let(:event) { FactoryGirl.create :event }
  let(:user) { FactoryGirl.create :user }
  let(:url) { "/api/v1/users/#{user.facebook_id}/events.json" }

  it "should add an event to a user" do
    get url
    last_response.body.should == "{\"events\":{\"past\":[],\"future\":[]}}"

    post url, lastfm_id: event.lastfm_id
    last_response.body.should == "{\"response\":\"success\"}"
    
    user.reload
    user.events.count.should == 1
    user.events.first.name.should == "pRIvate"
  end

  it "should check if the user has that event" do
    user.events << event

    get url, lastfm_id: event.lastfm_id
    last_response.body.should == "{\"response\":true}"

    get url, lastfm_id: 12345
    last_response.body.should == "{\"response\":false}"
  end
end

describe "/api/v1/users/:facebook_uuid/events/:id", type: :api, vcr: true do
  let(:event) { FactoryGirl.create :event }
  let(:user) { FactoryGirl.create :user }
  let(:url) { "/api/v1/users/#{user.facebook_id}/events/#{event.lastfm_id}.json" }

  it "should delete a event from the user's events" do
    user.events << event

    delete url

    user.reload
    user.events.count.should == 0
  end
end