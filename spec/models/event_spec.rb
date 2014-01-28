# == Schema Information
#
# Table name: events
#
#  id               :uuid             not null, primary key
#  lastfm_id        :string(255)
#  name             :string(255)
#  website          :string(255)
#  url              :string(255)
#  flickr_tag       :string(255)
#  headliner        :string(255)
#  start_date       :datetime
#  local_start_time :datetime
#  tickets_url      :string(255)
#  venue_id         :uuid
#  created_at       :datetime
#  updated_at       :datetime
#  sidekiq_workers  :text
#

require 'spec_helper'

describe Event, :vcr do
  it "should be populating? when jobs are in progress" do
    event = FactoryGirl.create :rolling_stones
    event.populating?.should be_false
    event.populate!
    event.populating?.should be_true

    Populator::Start.drain
    event.reload
    event.populating?.should be_true

    Populator::Instagram.drain
    Populator::InstagramLocation.drain
    event.populating?.should be_true

    Populator::Flickr.drain
    Populator::Youtube.drain

    Sidekiq::Worker.drain_all
    event.populating?.should be_true
  end

  it "should format timestamps when exported as JSON" do
    event = FactoryGirl.create :rolling_stones
    event.to_json.include?('Fri, 07 Jun 2013 04:00:00 +0000').should be_true
  end

  it "should round the time to half-hour periods" do
    event = FactoryGirl.build :rolling_stones
    event.start_date = DateTime.parse('3rd Feb 2001 04:05:06 EST')
    event.save
    event.reload
    event.start_date.should == DateTime.parse('3rd Feb 2001 04:00:00 EST')

    event.start_date = DateTime.parse('3rd Feb 2001 04:26:06 EST')
    event.save
    event.reload
    event.start_date.should == DateTime.parse('3rd Feb 2001 04:30:00 EST')

    event.start_date = DateTime.parse('3rd Feb 2001 04:00:00 EST')
    event.save
    event.reload
    event.start_date.should == DateTime.parse('3rd Feb 2001 04:00:00 EST')
  end

  it "should have at least one artist assigned" do
    event = FactoryGirl.build :rolling_stones
    event.artists = []
    saved = event.save
    saved.should be_false
    event.valid?.should be_false
    event.errors[:artists].should_not be_empty

    event.artists = [Artist.first]
    saved = event.save
    saved.should be_true
    event.valid?.should be_true
    event.errors[:artists].should be_empty
  end

  it "should have start_date assigned" do
    event = FactoryGirl.build :rolling_stones
    event.start_date = nil
    saved = event.save
    saved.should be_false
    event.valid?.should be_false
    event.errors[:start_date].should_not be_empty

    event.start_date = DateTime.parse('3rd Feb 2001 04:05:06 EST')
    saved = event.save
    saved.should be_true
    event.valid?.should be_true
    event.errors[:start_date].should be_empty
  end

  it "should provide a list of friends of a user, who attended an event" do
    event = FactoryGirl.create :past_event
    event2 = FactoryGirl.create :future_event

    user1 = FactoryGirl.create :user, name: "Aldous Huxley",   facebook_id: 83614697
    user2 = FactoryGirl.create :user, name: "George Orwell",   facebook_id: 9836592
    user3 = FactoryGirl.create :user, name: "Rudyard Kipling", facebook_id: 83987321
    user4 = FactoryGirl.create :user, name: "James Joyce",     facebook_id: 966548971

    user1.events = [event, event2]
    user1.save
    user3.events << event
    user3.save

    Event::FriendVisitor.create user: user1, friend: user2, event: user1.events[0]
    Event::FriendVisitor.create user: user3, friend: user4, event: user3.events[0]

    friends_of_user1 = event.friends_who_attended(user1)
    friends_of_user1.length.should == 1
    friends_of_user1[0].name.should == "George Orwell"

    friends_of_user3 = event.friends_who_attended(user3)
    friends_of_user3.length.should == 1
    friends_of_user3[0].name.should == "James Joyce"

    event2.friends_who_attended(user1).should == []
    event2.friends_who_attended(user3).should == []
  end
end
