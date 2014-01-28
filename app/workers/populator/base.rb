class Populator::Base
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options :queue => :default, :backtrace => true
end