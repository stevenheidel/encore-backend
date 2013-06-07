# == Schema Information
#
# Table name: setlist_songs
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  itunes_link :string(255)
#  concert_id  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class SetlistSong < ActiveRecord::Base
  belongs_to :concert
end
