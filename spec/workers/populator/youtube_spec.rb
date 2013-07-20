require 'spec_helper'

describe Populator::Youtube, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }
  let(:event2) { FactoryGirl.create :event,
    name: "Doobie Brothers", 
    start_date: "Oct 12, 2012"}

  describe '.perform' do
    before do
      Populator::Youtube.new.perform(event2.id)
    end

    it 'should get some videos from Youtube' do
      Post::YoutubeVideo.count.should_not == 0
    end
  end
end