require 'spec_helper'

describe Geo, :vcr do
  let(:user) { FactoryGirl.create :user }

  it "should get nearby venues" do
    event  = FactoryGirl.create :rolling_stones
    event2 = FactoryGirl.create :past_event
    event3 = FactoryGirl.create :future_event
    event.users << user
    user.events << event

    Geo.new(43.670906, -79.393331).past_events.count.should == 1
  end

  it "should not show Today's events in Past events list" do
    Timecop.freeze(Time.local(2013,8,26,19,00,00))
    venue = FactoryGirl.create :air_canada_centre

    today_event = FactoryGirl.build :event
    today_event.start_date = Time.now
    today_event.venue = venue
    today_event.user_count = 1
    today_event.save

    past_event = FactoryGirl.build :past_event
    past_event.venue = venue
    past_event.user_count = 1
    past_event.save

    future_event = FactoryGirl.build :future_event
    future_event.venue = venue
    future_event.user_count = 1
    future_event.save

    Geo.new(43.670906, -79.393331).past_events.to_a.length.should == 1

    Timecop.return
  end

  it "should return tickets URL in Today events list" do
    events = Geo.new(43.670906, -79.393331).todays_events.to_a
    events[1].headliner.should == "Soulfly"
    events[1].tickets_url.should == "http://www.ticketmaster.ca/event/10004B23C3BB8DC6"
  end

  it "should paginate the Future events list" do
    events = Geo.new(43.670906, -79.393331).future_events({limit: 5}).to_a
    events.length.should == 5
    events[0].headliner.should == "Hatebreed"
    events[4].headliner.should == "Joe Satriani"

    events = Geo.new(43.670906, -79.393331).future_events({page: 2, limit: 5}).to_a
    events.length.should == 5
    events[0].headliner.should == "UFO"
    events[4].headliner.should == "Eric Andersen"

    # no pagination provided
    events = Geo.new(43.670906, -79.393331).future_events.to_a
    events.length.should == 30
    events[0].headliner.should == "Hatebreed"
    events[29].headliner.should == "Paper Lions"

    # pagination exceeds max value of retrieved = 200,
    # should return everything retrieved approx 200 (except the Today's events)
    events = Geo.new(43.670906, -79.393331).future_events({page: 15, limit: 20}).to_a
    events.length.should == 189
    events[0].headliner.should == "Hatebreed"
    events[188].headliner.should == "Melt-Banana"
  end

  it "should accept string-values for pagination" do
    events = Geo.new(43.670906, -79.393331).future_events({page: '2', limit: '5'}).to_a
    events.length.should == 5
    events[0].headliner.should == "Deltron 3030"
    events[4].headliner.should == "Zachary Lucky"
  end

  it "should return tickets URL in Future events list" do
    events = Geo.new(43.670906, -79.393331).future_events({limit: 30, page: 2}).to_a
    events[1].headliner.should == "Guy J"
    events[1].tickets_url.should == "http://wantickets.com/Events/140183/Lost-Found-with-GUY-J/"
  end
end
