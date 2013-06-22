require 'spec_helper'

describe TodaysConcerts, vcr: false do
  before do
    TodaysConcerts.new.perform(Date.today.strftime("%F"), "Toronto")
  end

  describe '.perform' do
    it "should get a list of today's concerts" do
      Concert.count.should_not == 0
    end
  end
end