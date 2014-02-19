class Saver::InstagramDeadLinks
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options :queue => :default, :backtrace => true

  recurrence { weekly }

  # Remove forbidden images from Instagram (ie. they've been deleted)
  def perform
    to_destroy = []

    Post::InstagramPhoto.all.each_with_index do |p,i|
      if Faraday.head(p.image_url).status == 403
        to_destroy << p.id
      end
    end

    # Ensure we're not deleting more than 5% at a time
    if to_destroy.length < (Post::InstagramPhoto.count * 0.05)
      Post::InstagramPhoto.destroy(to_destroy)
    else
      raise "Instagram Dead Links attempted to remove more than 5% of the instagram image"
    end
  end
end