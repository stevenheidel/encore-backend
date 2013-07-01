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

class SetlistSong
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :itunes_link, type: String

  belongs_to :concert
end
