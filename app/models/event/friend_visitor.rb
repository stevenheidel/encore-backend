class Event::FriendVisitor
  belongs_to :user
  belongs_to :friend, class_name: "User"
  belongs_to :event
end