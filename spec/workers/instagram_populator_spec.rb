require 'spec_helper'

describe InstagramPopulator, :vcr do
  let(:concert) { FactoryGirl.create :concert }

  before do
    InstagramPopulator.perform_async(concert.id)
  end

  describe '.perform' do
    it 'should get some posts from Instagram' do
      InstagramPhoto.count.should > 0
    end
  end
end