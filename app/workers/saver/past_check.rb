class Saver::UpdateCounts
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options :queue => :default, :backtrace => true

  recurrence { daily }

  # Update past events lists
  def perform
    artists = Artist.where("past_event_freshness <= ?", 5.days.ago)

    artists.each do |a|
      Saver::PastEvents.perform_async(a.lastfm_id)
    end
  end
end