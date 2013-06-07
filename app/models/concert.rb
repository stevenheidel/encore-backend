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
#

class Concert < ActiveRecord::Base
  has_one :time_capsule

  belongs_to :venue
  belongs_to :concert
  has_many :setlist_songs
end
