class InstagramPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    concert = Concert.find(concert_id)

    # Populate with Instagram Photos by Locations
    if concert.venue.instagram_locations.count == 0
      InstagramLocation.find_instagram_ids_for_venue(concert.venue)
    end
    concert.venue.instagram_locations.each do |location|
      InstagramLocationPopulator.perform_async(concert_id, location.instagram_uuid)
    end

    InstagramSearchPopulator.perform_async(concert_id)
  end
end