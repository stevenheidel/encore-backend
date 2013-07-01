class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :caption, type: String
  field :link, type: String
  field :image_url, type: String
  field :user_name, type: String
  field :user_profile_picture, type: String

  belongs_to :concert

  validates_uniqueness_of :link, scope: :concert
end