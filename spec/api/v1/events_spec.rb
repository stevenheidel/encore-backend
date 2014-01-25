require 'spec_helper'

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
    user.events.first.name.should == "Event Name"
  end

  it "should check if the user has that event" do
    user.events << event

    get url, lastfm_id: event.lastfm_id
    last_response.body.should == "{\"response\":true}"

    get url, lastfm_id: 666
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

describe "Events", type: :api, vcr: true do
  it "should not show tomorrow's events in Today events list" do
    Timecop.freeze(Time.local(2013,11,23,19,00,00))

    events_response = get "/api/v1/events/today?latitude=43.670906&longitude=-79.393331"
    events = JSON.parse(events_response.body)['events']
    events.count.should == 10
    
    Timecop.return
  end

  describe "future" do
    let(:url) { "/api/v1/events/future.json?latitude=40.2740925407026&longitude=-111.6763645239655&radius=0.5" }

    it "should always return an array of events" do
      Timecop.freeze(Time.local(2014,01,24,19,00,00))

      get url # has only one upcoming event, and has to be returned in "events" array
      JSON.parse(last_response.body)["events"][0]["lastfm_id"].should == "3776354"
      
      Timecop.return
    end
  end
end