# == Schema Information
#
# Table name: user_photos
#
#  id                 :integer          not null, primary key
#  concert_id         :string(255)
#  user_id            :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class UserPhoto < ActiveRecord::Base
  belongs_to :concert
  belongs_to :user 

  has_attached_file :photo

  attr_accessible :photo_file_name # for Paperclip
end