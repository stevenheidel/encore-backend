require 'spec_helper'

describe InstagramLocationPopulator, :vcr do
  let(:concert) { FactoryGirl.create :concert }

  before do
    # "76266" is Sound Academy
    InstagramLocationPopulator.new.perform(concert.id, 76266)
  end

  describe '.perform' do
    it 'should get some posts from Instagram' do
      Post::InstagramPhoto.count.should > 0
    end
  end
end