require 'database_cleaner'

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end