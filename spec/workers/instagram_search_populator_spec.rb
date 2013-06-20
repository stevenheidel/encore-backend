require 'spec_helper'

describe InstagramSearchPopulator do
  let(:concert) { FactoryGirl.create :rolling_stones }

  describe '.perform' do
    it 'should get some posts from Instagram' do
      pending "Instagram search by date is unreliable at best" # TODO Fix

      InstagramSearchPopulator.new.perform(concert.id)

      InstagramPhoto.count.should > 0
    end
  end
end