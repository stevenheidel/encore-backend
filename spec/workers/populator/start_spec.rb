require 'spec_helper'

describe Populator::Start, :vcr do
  let(:event) { FactoryGirl.create :past_event }

  describe '.perform' do
    it 'should queue other populators' do
      expect {
        Populator::Start.new.perform(event.id)
        }.to change(Populator::Instagram.jobs, :size).by(1)
      # TODO: Flickr, Twitter, etc.
    end
  end
end