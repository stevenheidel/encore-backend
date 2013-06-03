class ConcertPopulator
  include Sidekiq::Worker

  def perform(concert_id)
    # Create a timecapsule that belongs to concert
    concert = Concert.find_by_id(concert_id)
    concert.time_capsule ||= TimeCapsule.create(populated: false, concert: concert)
    return if concert.time_capsule.populated

    pp concert

    # Populate with Instagram Photos by Locations
    InstagramLocation.search(concert.venue.latitude, concert.venue.longitude).each do |location|
      InstagramLocation.recent_media(location.id, concert.start_time, concert.end_time).each do |media|
        unless InstagramPhoto.where(:link => media.link, :time_capsule => concert.time_capsule).exists?
          InstagramPhoto.create({
            instagram_id: media.id,
            caption: media.caption.try(:text),
            link: media.link,
            image_url: media.images.standard_resolution.url,
            time_capsule: concert.time_capsule,
            user_name: media.user.username,
            user_profile_picture: media.user.profile_picture,
            user_id: media.user.id
          },
          :without_protection => true # TODO change this
          )
        end
      end
    end

    # Set populated to true
    concert.time_capsule.populated = true
    concert.time_capsule.save
  end
end