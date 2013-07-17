require 'spec_helper'

describe Populator::InstagramLocation, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }

  before do
    # "76266" is Sound Academy
    Populator::InstagramLocation.new.perform(event.id, 76266)
  end

  describe '.perform' do
    it 'should get some posts from Instagram' do
      Post::InstagramPhoto.count.should > 0
    end
  end
end