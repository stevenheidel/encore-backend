class Lastfm::Image
  include Mongoid::Document

  field :size, type: String
  field :url, type: String

  embedded_in :concert

  validates_uniqueness_of :size, :url
end