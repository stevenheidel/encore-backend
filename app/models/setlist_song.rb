class SetlistSong
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :itunes_link, type: String

  belongs_to :concert
end
