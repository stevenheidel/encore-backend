class Artist
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :songkick_uuid, type: Integer

  has_many :concerts
end
