class Lastfm::Image
  include Mongoid::Document

  field :size, type: String
  field :url, type: String

  embedded_in :event

  validates_uniqueness_of :size, :url
end