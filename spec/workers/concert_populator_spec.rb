require 'spec_helper'

describe ConcertPopulator, :vcr do
  let(:concert) { FactoryGirl.create :concert }

  before do
    ConcertPopulator.perform_async(concert.id)
    concert.reload
  end

  describe '.perform' do
    it 'should create a populated time capsule' do
      concert.time_capsule.should_not be_nil
      concert.time_capsule.populated.should be_true
    end

    it 'should get some posts from Instagram' do
      #p InstagramPhoto.all
    end
  end
end