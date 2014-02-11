namespace :encore do
  desc "Update all events in the database with new information"
  task :update => :environment do
    Event.all.each do |e|
      Saver::UpdateEvent.perform_async(e.lastfm_id)
    end

    puts "Queued!"
  end
end