require 'spec_helper'

describe ConcertPopulator, :vcr do
  let(:concert) { FactoryGirl.create :concert }

  before do
    # "76266" is Sound Academy
    InstagramLocationPopulator.perform_async(concert.id, "76266")
  end

  describe '.perform' do
    it 'should get some posts from Instagram' do
      InstagramPhoto.count.should > 0
    end
  end
end