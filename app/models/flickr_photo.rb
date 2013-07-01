# == Schema Information
#
# Table name: flickr_photos
#
#  id            :integer          not null, primary key
#  flickr_uuid   :integer
#  flickr_secret :string(255)
#  link          :string(255)
#  image_url     :string(255)
#  concert_id    :integer
#  title         :string(255)
#  description   :text
#  user_name     :string(255)
#  user_uuid     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class FlickrPhoto
  include Mongoid::Document
  include Mongoid::Timestamps

  field :flickr_uuid, type: Integer 
  field :flickr_secret, type: String 
  field :link, type: String 
  field :image_url, type: String
  field :title, type: String
  field :description, type: String
  field :user_name, type: String
  field :user_uuid, type: String

  belongs_to :concert

  validates_uniqueness_of :link, scope: :concert

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
