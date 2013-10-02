module Concerns::Postable
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :caption, type: String
  field :link, type: String
  field :image_url, type: String
  field :user_name, type: String
  field :user_profile_picture, type: String

  belongs_to :event
  embeds_many :flags, class_name: "Post::Flag"
  accepts_nested_attributes_for :flags # Railsadmin

  validates_uniqueness_of :link, scope: :event

  scope :flickr, where(:_type => "Post::FlickrPhoto")
  scope :instagram, where(:_type => "Post::InstagramPhoto")
  scope :youtube, where(:_type => "Post::YoutubeVideo")

  def add_flag(type, user_id)
    self.flags.create(type: type, user_id: user_id)
    self.destroy
  end

  # What kind of post is this? :instagram_photo, :youtube_video, etc.
  def type
    self.class.to_s.split("::").last.underscore.to_sym
  end
end