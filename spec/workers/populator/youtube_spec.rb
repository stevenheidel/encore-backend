require 'spec_helper'

describe Populator::Youtube, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }

  describe '.perform' do
    before do
      Populator::Youtube.new.perform(event.id)
    end

    it 'should get some videos from Youtube' do
      Post::YoutubeVideo.count.should_not == 0
    end
  end
end