class Post::InstagramPhoto < ActiveRecord::Base
  # TODO: add belongs_to instagram_location or something
  
  # Builds an object from JSON returned by Instagram
  def self.build_from_hashie(hashie)
    self.new(
      instagram_uuid: hashie.id,
      caption: hashie.caption.try(:text),
      link: hashie.link,
      image_url: hashie.images.standard_resolution.url,
      user_name: hashie.user.username,
      user_profile_picture: hashie.user.profile_picture,
      user_uuid: hashie.user.id
    )
  end
end
