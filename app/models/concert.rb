# == Schema Information
#
# Table name: concerts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  venue_id    :integer
#  date        :date
#  created_at  :datetime
#  updated_at  :datetime
#  start_time  :datetime
#  end_time    :datetime
#  eventful_id :string(255)
#  artist_id   :integer
#  populated   :boolean
#

class Concert < ActiveRecord::Base
  belongs_to :artist
  belongs_to :venue
  has_many :setlist_songs

  has_many :attendances
  has_many :users, through: :attendances

  # All the fun associations
  has_many :instagram_photos
  has_many :user_photos

  def posts
    self.instagram_photos + self.user_photos
  end
end
