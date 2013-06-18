require 'spec_helper'

describe ConcertPopulator, :vcr do
  let(:concert) { FactoryGirl.create :concert }

  describe '.perform' do
    it 'should create a populated time capsule' do
      ConcertPopulator.new.perform(concert.id)

      concert.reload
      concert.populated.should be_true
    end

    it 'should queue other populators' do
      expect {
        ConcertPopulator.new.perform(concert.id)
        }.to change(InstagramPopulator.jobs, :size).by(1)
      # Flickr
      # Twitter...
    end
  end
end