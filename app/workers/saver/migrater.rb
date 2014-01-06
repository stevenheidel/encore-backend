class Saver::Migrater
  include Sidekiq::Worker
  sidekiq_options :queue => :saver, :backtrace => true

  def perform(facebook_id)
    user = User.find_or_create_by!(facebook_id: facebook_id.to_i)

    
  end
end