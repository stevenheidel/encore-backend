require 'facebook_api'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :facebook_id, type: Integer 
  field :oauth_string, type: String 
  field :oauth_expiry, type: DateTime 
  field :name, type: String

  has_and_belongs_to_many :events, index: true
  has_many :user_photos, class_name: "Post::UserPhoto"
  has_many :event_friend_visitors, class_name: "Event::FriendVisitor", inverse_of: :user

  index({facebook_id: 1}, {unique: true})

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

  def add_friends_who_attended_event(event, facebook_ids)
    self.delete_friends_who_attended_event(event)
    Saver::FriendVisitors.perform_async(self.id.to_s, event.id.to_s, facebook_ids)
  end

  def delete_friends_who_attended_event(event)
    Event::FriendVisitor.destroy_all(user: self, event: event)
  end
end
