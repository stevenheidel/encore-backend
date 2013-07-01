class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :facebook_uuid, type: Integer 
  field :oauth_string, type: String 
  field :oauth_expiry, type: DateTime 
  field :name, type: String

  has_and_belongs_to_many :concerts

  has_many :user_photos, class_name: "Post::UserPhoto"
end
