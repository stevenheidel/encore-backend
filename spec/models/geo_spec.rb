require 'spec_helper'

describe Geo, :vcr do
  let!(:event) { FactoryGirl.create :rolling_stones }

  it "should get nearby venues" do
    pp Geo.new(43.670906, -79.393331).past_events.entries
  end
end
