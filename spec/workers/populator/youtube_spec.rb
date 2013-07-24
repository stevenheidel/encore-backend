require 'spec_helper'

describe Populator::Youtube, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }
  let(:event2) { FactoryGirl.create :event,
    name: "Doobie Brothers", 
    start_date: "Oct 12, 2012"}
  let(:event_with_not_for_mobile_youtubes) { FactoryGirl.create :event,
    name: "Justin Bieber",
    start_date: "December 18, 2010 19:06",
    venue: FactoryGirl.create(:venue, city: "Miami")
    }

  describe '.perform' do
    it 'should get some videos from Youtube' do
      Populator::Youtube.new.perform(event2.id)
      Post::YoutubeVideo.count.should_not == 0
    end
    
    it 'should ignore unplayable videos' do
      Populator::Youtube.new.perform(event_with_not_for_mobile_youtubes.id)
      Post::YoutubeVideo.count # TODO example of youtube video that doesn't play:
      # http://www.youtube.com/v/TwmQzCtErxQ?version=3&f=videos&d=Ab-9veXVzISEkHOrC_Mc4coO88HsQjpE1a8d1GxQnGDm&app=youtube_gdata
    end
    
    it 'should find a valid date in a string' do
      string = "The Doobie Brothers - Listen to the music - Live at Massey Hall Oct 12 2012".downcase # http://goo.gl/zepjzp
      Populator::Youtube.valid_date?(event2.start_date, string).should be(true)
    end

  end
end