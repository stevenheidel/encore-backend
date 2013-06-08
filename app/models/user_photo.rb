class UserPhoto < ActiveRecord::Base
  belongs_to :time_capsule
  belongs_to :user 

  has_attached_file :photo
end
