class Populator::Base
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options :queue => :priority, :backtrace => false
end
