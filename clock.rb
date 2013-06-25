require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  configure do |config|
    config[:tz] = "Eastern Time (US & Canada)"
  end

  every(1.day, "today's concerts", :at => '06:00') do
    # TODO: disabled for now
    #TodaysConcerts.perform_async(Date.today, "Toronto")
  end
end