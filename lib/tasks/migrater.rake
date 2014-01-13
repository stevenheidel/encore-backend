namespace :encore do
  desc "Migrate from the old database in migration.txt"
  task :migrate => :environment do
    migration_filename = File.join(File.expand_path(File.dirname(__FILE__)), 'migration.txt')
    contents = File.read(migration_filename)

    result = {}
    contents.split("\n\n").each do |u|
      x = u.split("\n")
      key = x.shift
      result[key] = x
    end

    puts "Read file, now adding users"

    result.each do |facebook_id, events_to_add|
      puts "Adding concerts for user: #{facebook_id}"
      user = User.find_or_create_by!(facebook_id: facebook_id)

      events_to_add.each do |e|
        puts "Adding event id: #{e}"
        event = Event.find_or_create_from_lastfm(e)

        before_count = user.events.count
        user.events << event
        event.populate! unless user.events.count == before_count
      end
    end

    puts "Done!"
  end
end