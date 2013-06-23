class ConcertPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    # Create a timecapsule that belongs to concert
    concert = Concert.find(concert_id)
    return if concert.populated

    if Time.now < concert.start_time # concert is in the future
      ConcertPopulator.perform_at(concert.start_time, concert_id)
    else
      if Time.now < concert.end_time # concert is in progress
        ConcertPopulator.perform_at(1.hour.from_now)
      else # concert has passed
        concert.populated = true
        concert.save
      end

      InstagramPopulator.perform_async(concert.id)
      FlickrPopulator.perform_async(concert.id)
    end
  end
end