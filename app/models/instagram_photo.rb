# == Schema Information
#
# Table name: instagram_photos
#
#  id                   :integer          not null, primary key
#  instagram_uuid       :string(255)
#  caption              :text
#  link                 :string(255)
#  image_url            :string(255)
#  concert_id           :integer
#  user_name            :string(255)
#  user_profile_picture :string(255)
#  user_uuid            :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

# TODO: add belongs_to instagram_location or something

class InstagramPhoto < ActiveRecord::Base
  belongs_to :concert

  validates_uniqueness_of :link, scope: :concert

  # Builds an object from JSON returned by Instagram
  def self.build_from_hashie(hashie)
    self.create({
      instagram_uuid: hashie.id,
      caption: hashie.caption.try(:text),
      link: hashie.link,
      image_url: hashie.images.standard_resolution.url,
      user_name: hashie.user.username,
      user_profile_picture: hashie.user.profile_picture,
      user_uuid: hashie.user.id
    },
    :without_protection => true # TODO avoid this
    )
  end
end
