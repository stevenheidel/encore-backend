require 'spec_helper'

describe TodaysConcerts, vcr: true do
  before do
    TodaysConcerts.new.perform(Date.today.strftime("%F"), "Toronto")
  end

  describe '.perform' do
    it "should get a list of today's concerts" do
      pending "probably won't do this"
      Concert.count.should_not == 0

      ConcertPopulator.jobs.count.should == Concert.count
    end
  end
end