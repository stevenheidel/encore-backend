namespace :encore do
  desc "Update all events in the database with new information"
  task :update => :environment do
    Event.all.each do |e|
      Saver::UpdateEvent(e.lastfm_id)
    end

    puts "Queued!"
  end
end