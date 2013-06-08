class ConcertPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    # Create a timecapsule that belongs to concert
    concert = Concert.find_by_id(concert_id)
    return if concert.populated

    InstagramPopulator.perform_async(concert.id)
    #FlickrPopulator.perform_async(concert.id)
    #TwitterPopulator.perform_async(concert.id)

    # Set populated to true
    concert.populated = true
    concert.save
  end
end