require 'spec_helper'

describe Geo, :vcr do
  it "should get nearby venues" do
    pp Geo.new(43.670906, -79.393331).past_events.entries
  end
end
