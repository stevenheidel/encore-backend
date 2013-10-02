class Post::UserPhoto < ActiveRecord::Base
  belongs_to :user

  has_attached_file :photo

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
