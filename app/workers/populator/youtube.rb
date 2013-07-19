require 'youtube_api'

class Populator::Youtube < Populator::Base
  def perform(event_id)
    event = Event.find(event_id)

    event.posts << Post::YoutubeVideo.build_from_response(YoutubeAPI.search("random")[0])
  end
end