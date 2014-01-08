class Saver::Migrater
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :backtrace => true

  def perform(facebook_id)
    user = User.find_or_create_by!(facebook_id: facebook_id)

    migration_filename = File.join(File.expand_path(File.dirname(__FILE__)), 'migration.txt')
    contents = File.read(migration_filename)

    result = {}
    contents.split("\n\n").each do |u|
      x = u.split("\n")
      key = x.shift
      result[key] = x
    end
    
    events_to_add = result[facebook_id.to_s]

    events_to_add.each do |e|
      event = Event.find_or_create_from_lastfm(e)

      before_count = user.events.count
      user.events << event
      event.populate! unless user.events.count == before_count
    end
  end
end