require 'spec_helper'

describe InstagramLocation, vcr: false do
  let(:venue) { FactoryGirl.create :venue }
  let(:aircanada1) { FactoryGirl.create :air_canada_centre,
    latitude: 43.6440859, longitude: -79.3783696 }
  let(:aircanada2) { FactoryGirl.create :air_canada_centre,
    latitude: 43.6437852, longitude: -79.3784416 }
  let(:rogerscentre) { FactoryGirl.create :venue,
    name: "Rogers Centre", latitude: 43.641658, longitude: -79.39180639999999 }

  describe '.find_instagram_ids_for_venue' do
    it 'should get instagram ids for Sound Academy' do
      InstagramLocation.find_instagram_ids_for_venue(venue)

      InstagramLocation.all.count.should > 0
    end

    it 'should get instagram ids for Air Canada Centre' do
      InstagramLocation.find_instagram_ids_for_venue(aircanada1)
      InstagramLocation.find_instagram_ids_for_venue(aircanada2)

      aircanada1.instagram_locations.map{|x|x.instagram_uuid}.sort.should ==
        aircanada2.instagram_locations.map{|x|x.instagram_uuid}.sort
    end

    it 'should get instagram ids for Rogers Centre' do
      InstagramLocation.find_instagram_ids_for_venue(rogerscentre)

      rogerscentre.instagram_locations.count.should > 0
    end
  end
end
