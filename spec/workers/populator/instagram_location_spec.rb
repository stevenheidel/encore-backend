require 'spec_helper'

describe Populator::InstagramLocation, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }

  before do
    # "35940" is Air Canada Centre
    Populator::InstagramLocation.new.perform(event.id, 35940)
  end

  describe '.perform' do
    it 'should get some posts from Instagram' do
      Post::InstagramPhoto.count.should > 0
      pp Post::InstagramPhoto.all.entries
    end
  end
end