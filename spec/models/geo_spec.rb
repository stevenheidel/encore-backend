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
    Timecop.freeze(Time.local(2013,10,10,15,00,00))

    events = Geo.new(43.670906, -79.393331).todays_events.to_a
    events[1].headliner.should == "Soulfly"
    events[1].tickets_url.should == "http://www.ticketmaster.ca/event/10004B23C3BB8DC6"

    Timecop.return
  end

  it "should paginate the Future events list" do
    Timecop.freeze(Time.local(2013,10,16,15,00,00))

    events = Geo.new(43.670906, -79.393331).future_events({limit: 5}).to_a
    events.length.should == 5
    events[0].headliner.should == "Zachary Lucky"
    events[4].headliner.should == "Fiona Apple"

    events = Geo.new(43.670906, -79.393331).future_events({page: 2, limit: 5}).to_a
    events.length.should == 5
    events[0].headliner.should == "Frightened Rabbit"
    events[4].headliner.should == "Delorean"

    # no pagination provided
    events = Geo.new(43.670906, -79.393331).future_events.to_a
    events.length.should == 30
    events[0].headliner.should == "Zachary Lucky"
    events[29].headliner.should == "Senses Fail"

    events = Geo.new(43.670906, -79.393331).future_events({page: 15, limit: 20}).to_a
    events.length.should == 20
    events[0].headliner.should == "Sepultura"
    events[19].headliner.should == "Limp Wrist"

    Timecop.return
  end

  it "should accept string-values for pagination" do
    Timecop.freeze(Time.local(2013,10,10,15,00,00))
    events = Geo.new(43.670906, -79.393331).future_events({page: '2', limit: '5'}).to_a
    events.length.should == 5
    events[0].headliner.should == "Deltron 3030"
    events[4].headliner.should == "Zachary Lucky"
    Timecop.return
  end

  it "should return tickets URL in Future events list" do
    Timecop.freeze(Time.local(2013,10,16,13,57,00))
    events = Geo.new(43.670906, -79.393331).future_events({limit: 30, page: 2}).to_a
    events[0].headliner.should == "Big D and the Kids Table"
    events[0].tickets_url.should == "http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=3730004"
    Timecop.return
  end
end
