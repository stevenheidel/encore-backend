class Populator::Instagram
  include Sidekiq::Worker

  def perform(event_id)
    event = Event.find(event_id)

    # Populate with Instagram Photos by Locations
    if event.venue.instagram_locations.count == 0
      InstagramLocation.find_instagram_ids_for_venue(event.venue)
    end
    event.venue.instagram_locations.each do |location|
      Populator::InstagramLocation.perform_async(event_id, location.instagram_uuid)
    end

    #Populator::InstagramSearch.perform_async(event_id) TODO disabled for now
  end
end