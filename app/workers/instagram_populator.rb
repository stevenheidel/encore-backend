class InstagramPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    concert = Concert.find(concert_id)

    # Populate with Instagram Photos by Locations
    InstagramLocation.search(concert.venue.latitude, concert.venue.longitude).each do |location|
      InstagramLocationPopulator.perform_async(concert_id, location.id.to_i)
    end

    InstagramSearchPopulator.perform_async(concert_id)
  end
end