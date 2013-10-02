# == Schema Information
#
# Table name: users
#
#  id               :uuid             not null, primary key
#  facebook_id      :integer
#  oauth_string     :string(255)
#  oauth_expiry     :datetime
#  name             :string(255)
#  invite_sent      :boolean
#  invite_timestamp :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe User, vcr: { record: :once, re_record_interval: nil } do
  it "should save a list of friends, who attended an event with user" do
    user1 = FactoryGirl.create :user, name: "Aldous Huxley",   facebook_id: 108533109171704
    event = FactoryGirl.create :past_event
    friends_json = [
        {facebook_id: "100003794798865", name: "George Orwell"}, 
        {facebook_id: "515605967",       name: "Rudyard Kipling"}, 
        {facebook_id: "659574643",       name: "James Joyce"}
    ]
    user1.events << event
    user1.save

    user1.add_friends_who_attended_event(event, friends_json)
    friends = user1.friends_who_attended_event(event)
    friends.length.should == 3
    friends.map(&:name).should include("George Orwell", "Rudyard Kipling", "James Joyce")


    user1.delete_friends_who_attended_event(event)
    friends = user1.friends_who_attended_event(event)
    friends.length.should == 0
  end

  it "should provide a list of friends, who attended an event with user" do
    event = FactoryGirl.create :past_event
    event2 = FactoryGirl.create :event

    user1 = FactoryGirl.create :user, name: "Aldous Huxley",   facebook_id: 83614697
    user2 = FactoryGirl.create :user, name: "George Orwell",   facebook_id: 9836592
    user3 = FactoryGirl.create :user, name: "Rudyard Kipling", facebook_id: 83987321
    user4 = FactoryGirl.create :user, name: "James Joyce",     facebook_id: 966548971

    user1.events = [event, event2]
    user1.save
    user3.events << event
    user3.save
    user4.events << event
    user4.save

    Event::FriendVisitor.create user: user1, friend: user2, event: user1.events[0]
    Event::FriendVisitor.create user: user1, friend: user4, event: user1.events[0]
    Event::FriendVisitor.create user: user1, friend: user3, event: user1.events[1]
    Event::FriendVisitor.create user: user3, friend: user4, event: user3.events[0]

    friends_of_user1 = user1.friends_who_attended_event(event)
    friends_of_user1.length.should == 2
    friends_of_user1[0].name.should == "George Orwell"
    friends_of_user1[1].name.should  == "James Joyce"

    friends_of_user1 = user1.friends_who_attended_event(event2)
    friends_of_user1.length.should == 1
    friends_of_user1[0].name.should == "Rudyard Kipling"

    friends_of_user3 = user3.friends_who_attended_event(event)
    friends_of_user3.length.should == 1
    friends_of_user3[0].name.should == "James Joyce"

    user4.friends_who_attended_event(event).should == []
    user4.friends_who_attended_event(event2).should == []
  end
end
