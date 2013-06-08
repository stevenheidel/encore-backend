# == Schema Information
#
# Table name: time_capsules
#
#  id         :integer          not null, primary key
#  populated  :boolean
#  concert_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class TimeCapsule < ActiveRecord::Base
  belongs_to :concert

  # All the fun associations
  has_many :instagram_photos
  has_many :user_photos

  def posts
    self.instagram_photos + self.user_photos
  end
end
