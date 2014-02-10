# == Schema Information
#
# Table name: friend_visitors
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  friend_id  :uuid
#  event_id   :uuid
#  created_at :datetime
#  updated_at :datetime
#

class Event::FriendVisitor < ActiveRecord::Base
  self.table_name = "friend_visitors"
  belongs_to :user
  belongs_to :friend, class_name: "User"
  belongs_to :event
end
