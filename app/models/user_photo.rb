# == Schema Information
#
# Table name: user_photos
#
#  id                 :integer          not null, primary key
#  concert_id         :integer
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class UserPhoto
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :concert
  belongs_to :user

  has_mongoid_attached_file :photo

  # TODO: Below is for indexing the posts
  def caption
    "Uploaded to Encore"
  end

  def image_url
    self.photo.url
  end

  def user_name
    self.user.name
  end

  def user_profile_picture
    "https://graph.facebook.com/#{self.user.facebook_uuid}/picture"
  end
end
