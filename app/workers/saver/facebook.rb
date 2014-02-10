class Saver::Facebook
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :backtrace => true

  def perform(facebook_ids)
    facebook_ids.each do |facebook_id|
      facebook_user_info = FacebookAPI.get_public_info(facebook_id)
      user = User.get(facebook_id)
      if facebook_user_info and user
        user.name = facebook_user_info["name"] 
        user.save!
      end
    end
  end
end

