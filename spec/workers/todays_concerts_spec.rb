require 'spec_helper'

describe TodaysConcerts, :vcr do
  before do
    TodaysConcerts.perform_async(Date.today, "Toronto")
  end

  describe '.perform' do
    it "should get a list of today's concerts" do
      
    end
  end
end