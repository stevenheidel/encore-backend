require 'spec_helper'

describe Event, :vcr do
  it "should be populating? when jobs are in progress" do
    event = FactoryGirl.create :rolling_stones
    event.populating?.should be_false
    event.populate!
    event.reload.populating?.should be_true

    Populator::Start.drain
    event.reload.populating?.should be_true

    Populator::Instagram.drain
    Populator::InstagramLocation.drain
    event.reload.populating?.should be_true

    Populator::Flickr.drain
    Populator::Youtube.drain
    event.reload.populating?.should be_false
  end

  it "should format timestamps when exported as JSON" do
    event = FactoryGirl.create :rolling_stones
    event.to_json.include?('Fri, 07 Jun 2013 04:00:00').should be_true
  end

  it "should round the time to half-hour periods" do
    event = FactoryGirl.build :rolling_stones
    event.start_date = DateTime.parse('3rd Feb 2001 04:05:06 EST')
    event.save
    event.reload
    event.start_date.should == DateTime.parse('3rd Feb 2001 04:00:00 EST')

    event.start_date = DateTime.parse('3rd Feb 2001 04:26:06 EST')
    event.save
    event.reload
    event.start_date.should == DateTime.parse('3rd Feb 2001 04:30:00 EST')

    event.start_date = DateTime.parse('3rd Feb 2001 04:00:00 EST')
    event.save
    event.reload
    event.start_date.should == DateTime.parse('3rd Feb 2001 04:00:00 EST')
  end
end