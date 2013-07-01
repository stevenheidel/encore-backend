class Post::UserPhoto < Post
  include Mongoid::Paperclip

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
