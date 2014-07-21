namespace :encore do
  desc "Export the database to be imported into Scala's MongoDB database"
  task :export => :environment do
    User.all.each do |user|
      puts user
    end

    puts "Done!"
  end
end