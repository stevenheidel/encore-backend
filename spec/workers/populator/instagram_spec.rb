require 'spec_helper'

describe Populator::Instagram, vcr: true do
  let(:event) { FactoryGirl.create :rolling_stones }

  before do
    Populator::Instagram.new.perform(event.id)
  end

  describe '.perform' do
    it 'should queue up the right sub-populators' do
      event.venue.instagram_locations.count.should > 0

      Populator::InstagramLocation.jobs.size.should > 1
      #InstagramSearchPopulator.jobs.size.should == 1 TODO disabled for now
    end
  end
end