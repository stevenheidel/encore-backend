# == Schema Information
#
# Table name: users
#
#  id               :uuid             not null, primary key
#  facebook_id      :string(255)
#  oauth_string     :string(255)
#  oauth_expiry     :datetime
#  name             :string(255)
#  invite_sent      :boolean
#  invite_timestamp :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  events_count     :integer          default(0)
#

require 'facebook_api'

class User < ActiveRecord::Base
  has_and_belongs_to_many :events, -> { uniq }
  has_many :user_photos, class_name: "Post::UserPhoto"
  has_many :event_friend_visitors, class_name: "Event::FriendVisitor", inverse_of: :user

  validates_uniqueness_of :facebook_id

  # Get a user by the facebook id
  def self.get(facebook_id)
    self.find_by(facebook_id: facebook_id.to_s)
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
      friend = User.find_or_create_by(facebook_id: friend_json[:facebook_id].to_s)
      if friend_json[:name] and friend.name != friend_json[:name]
        friend.name = friend_json[:name]
        friend.invite_sent = friend_json[:invite_sent] if friend_json.has_key?(:invite_sent)
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

  def email
    if self.email_cache.blank? && self.oauth_string.present?
      # 7cd8b15f2dcc57e8033744930052ef2e is app_secret
      graph = Koala::Facebook::API.new(oauth_string, "7cd8b15f2dcc57e8033744930052ef2e")
      fb_email = graph.get_object("me")["email"]

      self.update(email_cache: fb_email)
    end

    self.email_cache
  end
end
