require 'spec_helper'

describe Geo, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }
  let(:event2) { FactoryGirl.create :past_event }
  let(:event3) { FactoryGirl.create :future_event }
  let(:user) { FactoryGirl.create :user }

  it "should get nearby venues" do
    event.users << user
    user.events << event

    Geo.new(43.670906, -79.393331).past_events.count.should == 1
  end
end
