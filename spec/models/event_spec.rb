require 'spec_helper'

describe Event, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }

  it "should be populating? when jobs are in progress" do
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
end