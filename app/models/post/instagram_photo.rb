# == Schema Information
#
# Table name: instagram_photos
#
#  id                   :uuid             not null, primary key
#  instagram_uuid       :string(255)
#  caption              :string(255)
#  link                 :string(255)
#  image_url            :string(255)
#  user_name            :string(255)
#  user_profile_picture :string(255)
#  user_uuid            :string(255)
#  event_id             :uuid
#  created_at           :datetime
#  updated_at           :datetime
#

class Post::InstagramPhoto < ActiveRecord::Base
  include Concerns::Postable

  # TODO: add belongs_to instagram_location or something
  
  # Builds an object from JSON returned by Instagram
  def self.build_from_hashie(hashie)
    self.new(
      instagram_uuid: hashie.id,
      caption: hashie.caption.try(:text).try(:truncate, 255),
      link: hashie.link,
      image_url: hashie.images.standard_resolution.url,
      user_name: hashie.user.username,
      user_profile_picture: hashie.user.profile_picture,
      user_uuid: hashie.user.id
    )
  end

  def type
    :instagram_photo
  end
end
