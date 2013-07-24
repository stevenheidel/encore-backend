class Populator::Base
  if Rails.env.test? # TODO: SidekiqStatus doesn't work in testing for some reason
    include Sidekiq::Worker
  else
    include SidekiqStatus::Worker
  end
  sidekiq_options :queue => :default, :backtrace => true
end