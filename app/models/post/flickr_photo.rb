# == Schema Information
#
# Table name: flickr_photos
#
#  id            :uuid             not null, primary key
#  flickr_uuid   :string(255)
#  flickr_secret :string(255)
#  link          :string(255)
#  image_url     :string(255)
#  title         :string(255)
#  description   :string(255)
#  user_name     :string(255)
#  user_uuid     :string(255)
#  event_id      :uuid
#  created_at    :datetime
#  updated_at    :datetime
#

class Post::FlickrPhoto < ActiveRecord::Base
  # Builds an object from JSON returned by Flickr
  def self.build_from_hashie(hashie)
    self.new(
      flickr_uuid: hashie.id,
      flickr_secret: hashie.secret,
      link: hashie.urls[0]._content,
      image_url: "http://farm#{hashie.farm}.staticflickr.com/#{hashie.server}/#{hashie.id}_#{hashie.secret}.jpg",
      title: hashie.title,
      description: hashie.description,
      user_name: hashie.owner.realname,
      user_uuid: hashie.owner.nsid
    )
  end
end
