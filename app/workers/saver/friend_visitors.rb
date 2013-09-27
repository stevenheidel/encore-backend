class Saver::FriendVisitors
  include Sidekiq::Worker
  sidekiq_options :queue => :saver, :backtrace => true

  def perform(user_id, event_id, friend_facebook_ids)
    event = Event.find(event_id)
    user  = User.find(user_id)
    user.add_friends_who_attended_event(event, friend_facebook_ids)
  end
end

