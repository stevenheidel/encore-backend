# == Schema Information
#
# Table name: instagram_locations
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  venue_id     :integer
#  instagram_id :integer
#

require 'spec_helper'

describe InstagramLocation, :vcr do
  let(:venue) { FactoryGirl.create :venue }
  let(:aircanada1) { FactoryGirl.create :venue, 
    name: "Air Canda Centre", latitude: 43.6440859, longitude: -79.3783696 }
  let(:aircanada2) { FactoryGirl.create :venue, 
    name: "Air Canda Centre", latitude: 43.6437852, longitude: -79.3784416 }

  describe '.find_instagram_ids_for_venue' do
    it 'should get instagram ids for Sound Academy' do
      InstagramLocation.find_instagram_ids_for_venue(venue)

      InstagramLocation.all.count.should > 0
    end

    it 'should get instagram ids for Air Canada Centre' do
      InstagramLocation.find_instagram_ids_for_venue(aircanada1)
      InstagramLocation.find_instagram_ids_for_venue(aircanada2)

      aircanada1.instagram_locations.map{|x|x.instagram_id}.sort.should ==
        aircanada2.instagram_locations.map{|x|x.instagram_id}.sort
    end
  end
end
