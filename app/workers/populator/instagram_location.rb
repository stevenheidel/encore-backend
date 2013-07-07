require 'instagram_api'

class Populator::InstagramLocation
  include Sidekiq::Worker

  def perform(event_id, instagram_location_id, instagram_max_id=nil)
    event = Event.find(event_id)

    result = InstagramAPI.location_recent_media(
      instagram_location_id,
      event.start_time, event.end_time,
      instagram_max_id
    )

    if (max_id = result.pagination.next_max_id)
      Populator::InstagramLocation.perform_async(event_id, instagram_location_id, max_id)
    end

    result.each do |media|
      event.posts << Post::InstagramPhoto.build_from_hashie(media)
    end
  end
end