require 'spec_helper'

describe InstagramPopulator, :vcr do
  let(:concert) { FactoryGirl.create :concert }

  before do
    InstagramPopulator.new.perform(concert.id)
  end

  describe '.perform' do
    it 'should queue up the right sub-populators' do
      concert.venue.instagram_locations.count.should > 0

      InstagramLocationPopulator.jobs.size.should > 1
      InstagramSearchPopulator.jobs.size.should == 1
    end
  end
end