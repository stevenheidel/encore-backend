require 'instagram_api'

class Populator::InstagramSearch
  include SidekiqStatus::Worker
  sidekiq_options :queue => :default, :backtrace => true

  def perform(event_id)
    event = Event.find(event_id)

    InstagramAPI.media_search(event.venue.latitude, event.venue.longitude,
          event.start_time, event.end_time).each do |media|
      event.posts << Post::InstagramPhoto.build_from_hashie(media)
    end
  end
end