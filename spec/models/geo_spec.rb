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

  it "should return tickets URL in Today events list", vcr: { record: :once, re_record_interval: nil } do
    Timecop.freeze(Time.local(2013,9,19,11,00,00))

    event = Geo.new(43.670906, -79.393331).todays_events.to_a[7]
    event.headliner.should == "Peter Hook And The Light"
    event.tickets_url.should == "http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&amp;eventId=3602664&amp;pl=embrace"

    Timecop.return
  end

  it "should return tickets URL in Future events list", vcr: { record: :once, re_record_interval: nil } do
    Timecop.freeze(Time.local(2013,9,19,11,00,00))
    event = Geo.new(43.670906, -79.393331).future_events.to_a[7]

    event.headliner.should == "Herbert Grönemeyer"
    event.tickets_url.should == "http://ticketf.ly/11UbDtS"
    Timecop.return
  end
end
