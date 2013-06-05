class InstagramPopulator
  include Sidekiq::Worker

  def perform(time_capsule_id)
    time_capsule = TimeCapsule.find(time_capsule_id)
    concert = time_capsule.concert

    # Populate with Instagram Photos by Locations
    InstagramLocation.search(concert.venue.latitude, concert.venue.longitude).each do |location|
      InstagramLocationPopulator.perform_async(time_capsule_id, location.id)
    end

    #pp InstagramAPI.media_search(concert.venue.latitude, concert.venue.longitude,
     # concert.start_time, concert.end_time)
  end
end