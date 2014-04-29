require 'spec_helper'

describe Populator::Flickr, vcr: true do
  let(:event) { FactoryGirl.create :rolling_stones }

  describe '.perform' do
    pending 'should get some posts from Flickr' do
      Populator::Flickr.new.perform(event.id)

      Post::FlickrPhoto.count.should > 0
    end
  end
end