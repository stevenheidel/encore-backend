require 'spec_helper'

describe Populator::InstagramSearch do
  let(:event) { FactoryGirl.create :rolling_stones }

  describe '.perform' do
    it 'should get some posts from Instagram' do
      pending "Instagram search by date is unreliable at best" # TODO Fix

      Populator::InstagramSearch.new.perform(event.id)

      InstagramPhoto.count.should > 0
    end
  end
end