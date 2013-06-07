# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  facebook_uuid :integer
#  oauth_string  :string(255)
#  oauth_expirty :datetime
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base
  has_many :attendances
  has_many :concerts, through: :attendances
end
