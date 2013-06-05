require 'instagram_api'

class InstagramLocationPopulator
  include Sidekiq::Worker

  def perform(time_capsule_id, instagram_location_id, instagram_max_id=nil)
    time_capsule = TimeCapsule.find(time_capsule_id)
    concert = time_capsule.concert

    result = InstagramAPI.location_recent_media(
      instagram_location_id, 
      concert.start_time, concert.end_time,
      instagram_max_id
    )
    
    if (max_id = result.pagination.next_max_id)
      p max_id
      InstagramLocationPopulator.perform_async(time_capsule_id, instagram_location_id, max_id)
    end

    result.each do |media|
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
        :without_protection => true # TODO avoid this
        )
      end
    end
  end
end