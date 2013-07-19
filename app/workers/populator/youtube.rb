require 'youtube_api'

class Populator::Youtube 
	include SidekiqStatus::Worker
	sidekiq_options :queue => :default, :backtrace => true

	def perform(event_id)
		event = Event.find(event_id)

		YoutubeAPI.search

	end
end