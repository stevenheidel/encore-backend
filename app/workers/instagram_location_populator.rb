require 'instagram_api'

class InstagramLocationPopulator
  include Sidekiq::Worker

  def perform(concert_id, instagram_location_id, instagram_max_id=nil)
    concert = Concert.find(concert_id)

    result = InstagramAPI.location_recent_media(
      instagram_location_id, 
      concert.start_time, concert.end_time,
      instagram_max_id
    )
    
    if (max_id = result.pagination.next_max_id)
      InstagramLocationPopulator.perform_async(concert_id, instagram_location_id, max_id)
    end

    result.each do |media|
      unless InstagramPhoto.where(:link => media.link, :concert => concert).exists?
        InstagramPhoto.create({
          instagram_id: media.id,
          caption: media.caption.try(:text),
          link: media.link,
          image_url: media.images.standard_resolution.url,
          concert: concert,
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