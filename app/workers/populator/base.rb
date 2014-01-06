class Populator::Base
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :backtrace => true
end