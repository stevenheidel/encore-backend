class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :caption, type: String
  field :link, type: String
  field :image_url, type: String
  field :user_name, type: String
  field :user_profile_picture, type: String

  belongs_to :event
  embeds_many :flags, class_name: "Post::Flag"
  accepts_nested_attributes_for :flags # Railsadmin

  validates_uniqueness_of :link, scope: :event

  def add_flag(type, user_id)
    self.flags.create(type: type, user_id: user_id)
  end

  # What kind of post is this? :instagram_photo, :youtube_video, etc.
  def type
    self.class.to_s.split("::").last.underscore.to_sym
  end
end