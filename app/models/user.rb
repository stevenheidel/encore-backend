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

require 'facebook_api'

class User < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_many :user_photos, class_name: "Post::UserPhoto"
  has_many :event_friend_visitors, class_name: "Event::FriendVisitor", inverse_of: :user

  #TODO: index({facebook_id: 1}, {unique: true})

  validates_uniqueness_of :facebook_id

  # Get a user by the facebook id
  def self.get(facebook_id)
    self.find_by(facebook_id: facebook_id.to_i)
  end

  def facebook_image_url
    "https://graph.facebook.com/#{self.facebook_id}/picture?type=large"
  end

  def friends_who_attended_event(event)
    event_friend_visitors.where(event: event).to_a.map {|company| company.friend}
  end

  def add_friends_who_attended_event(event, friends)
    return if friends.nil?
    friends.each do |friend_json|
      friend = User.find_or_create_by(facebook_id: friend_json[:facebook_id])
      if friend_json[:name] and friend.name != friend_json[:name]
        friend.name = friend_json[:name]
        friend.save
      end
      Event::FriendVisitor.create user: self, friend: friend, event: event
    end
  end

  def delete_friends_who_attended_event(event)
    Event::FriendVisitor.destroy_all(user: self, event: event)
  end

  def invited?
    (oauth_string or invite_sent) ? true : false
  end
end
