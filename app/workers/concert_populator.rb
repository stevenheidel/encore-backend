class ConcertPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    # Create a timecapsule that belongs to concert
    concert = Concert.find_by_id(concert_id)
    concert.time_capsule ||= TimeCapsule.create(populated: false, concert: concert)
    return if concert.time_capsule.populated

    InstagramPopulator.perform_async(concert.time_capsule.id)
    #FlickrPopulator.perform_async(concert.time_capsule.id)
    #TwitterPopulator.perform_async(concert.time_capsule.id)

    # Set populated to true
    concert.time_capsule.populated = true
    concert.time_capsule.save
  end
end