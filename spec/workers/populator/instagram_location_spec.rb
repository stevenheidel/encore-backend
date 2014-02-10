require 'spec_helper'

describe Populator::InstagramLocation, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }

  describe '.perform' do
    it 'should get some posts from Instagram' do
      Populator::InstagramLocation.new.perform(event.id, 35940)
      
      Post::InstagramPhoto.count.should > 0
    end
  end
end