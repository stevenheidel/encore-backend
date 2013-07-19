require 'youtube_api'

class Populator::Youtube < Populator::Base
  def perform(event_id)
    event = Event.find(event_id)

    pp YoutubeAPI.search("random")[0]
  end
end