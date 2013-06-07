require 'spec_helper'

describe ConcertPopulator, :vcr do
  let(:time_capsule) { FactoryGirl.create :time_capsule }

  before do
    # "76266" is Sound Academy
    InstagramLocationPopulator.perform_async(time_capsule.id, "76266")
  end

  describe '.perform' do
    it 'should get some posts from Instagram' do
      InstagramPhoto.count.should > 0
    end
  end
end