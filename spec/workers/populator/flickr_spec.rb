require 'spec_helper'

describe Populator::Flickr, vcr: true do
  let(:event) { FactoryGirl.create :rolling_stones }

  before do
    Populator::Flickr.new.perform(event.id)
  end

  describe '.perform' do
    it 'should get some posts from Flickr' do
      Post::FlickrPhoto.count.should > 0
    end
  end
end