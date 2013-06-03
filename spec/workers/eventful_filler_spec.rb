require 'spec_helper'

describe EventfulFiller, :vcr do
  let(:concert) { FactoryGirl.create :concert }

  before do
    EventfulFiller.perform_async(:concert, concert.id)
    concert.reload
  end

  describe '.perform' do
    it 'should get the start and end time for a concert' do
      concert.start_time.should_not be_nil
      concert.end_time.should_not be_nil
    end

    it 'should get the latitude and longitude of a venue' do
      concert.venue.latitude.class.should == BigDecimal
      concert.venue.longitude.class.should == BigDecimal
    end
  end
end