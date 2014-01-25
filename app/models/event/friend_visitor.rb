class Event::FriendVisitor < ActiveRecord::Base
  self.table_name = "friend_visitors"
  belongs_to :user
  belongs_to :friend, class_name: "User"
  belongs_to :event
end