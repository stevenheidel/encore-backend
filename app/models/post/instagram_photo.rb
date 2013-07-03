class Post::InstagramPhoto < Post
  field :instagram_uuid, type: String 
  field :user_uuid, type: String

  # TODO: add belongs_to instagram_location or something
  
  def caption=(value)
    # get rid of UTF-8 4 byte characters
    if value
      self[:caption] = value.each_char.select{|c| c.bytes.count < 4 }.join('')
    else
      self[:caption] = nil
    end
  end

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
