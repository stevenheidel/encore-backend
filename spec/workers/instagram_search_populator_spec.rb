require 'spec_helper'

describe InstagramSearchPopulator do
  let(:concert) { FactoryGirl.create :concert,
    name: "Rolling Stones",
    start_time: "May 25, 2013 15:00",
    end_time: "May 25, 2013 21:00",
    venue: FactoryGirl.create(:venue, 
      name: "Air Canada Centre",
      latitude: 43.6437852,
      longitude: -79.3784416,
      location: "Toronto") }

  before do
    InstagramSearchPopulator.perform_async(concert.id)
  end

  describe '.perform' do
    it 'should get some posts from Instagram' do
      InstagramPhoto.count.should > 0
      #InstagramPhoto.all.each{|l|puts l.link}
    end
  end
end