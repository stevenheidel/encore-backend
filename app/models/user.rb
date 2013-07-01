# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  facebook_uuid :integer
#  oauth_string  :string(255)
#  oauth_expiry  :datetime
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :facebook_uuid, type: Integer 
  field :oauth_string, type: String 
  field :oauth_expiry, type: DateTime 
  field :name, type: String

  has_and_belongs_to_many :concerts

  has_many :user_photos
end
