class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :facebook_id, type: Integer 
  field :oauth_string, type: String 
  field :oauth_expiry, type: DateTime 
  field :name, type: String

  has_and_belongs_to_many :events, index: true

  has_many :user_photos, class_name: "Post::UserPhoto"

  index({facebook_id: 1}, {unique: true})

  validates_uniqueness_of :facebook_id

  # Get a user by the facebook id
  def self.get(facebook_id)
    self.find_by(facebook_id: facebook_id.to_i)
  end

  def facebook_image_url
    "https://graph.facebook.com/#{self.facebook_id}/picture?type=large"
  end
end
