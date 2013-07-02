class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :facebook_id, type: Integer 
  field :oauth_string, type: String 
  field :oauth_expiry, type: DateTime 
  field :name, type: String

  has_and_belongs_to_many :events

  has_many :user_photos, class_name: "Post::UserPhoto"

  # TODO DEPRECATION
  def facebook_uuid
    puts "DEPRECATED: Use facebook_id instead"
    facebook_id
  end
  def facebook_uuid=(uuid)
    puts "DEPRECATED: Use facebook_id= instead"
    self.facebook_id = uuid
  end
end
