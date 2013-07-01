require 'spec_helper'

describe FlickrPopulator, :vcr do
  let(:concert) { FactoryGirl.create :rolling_stones }

  before do
    FlickrPopulator.new.perform(concert.id)
  end

  describe '.perform' do
    it 'should get some posts from Flickr' do
      Post::FlickrPhoto.count.should > 0
    end
  end
end