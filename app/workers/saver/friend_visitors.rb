class Saver::FriendVisitors
  include Sidekiq::Worker
  sidekiq_options :queue => :saver, :backtrace => true

  def perform(user_id, event_id, friend_facebook_ids)
    event = Event.find(event_id)
    user  = User.find(user_id)
    friend_facebook_ids.each do |facebook_id|
      friend = User.find_or_create_by(facebook_id: facebook_id)
      facebook_user_info = FacebookAPI.get_public_info(facebook_id)
      friend.name = facebook_user_info["name"] if facebook_user_info
      friend.save
      Event::FriendVisitor.create user: user, friend: friend, event: event
    end
  end
end

