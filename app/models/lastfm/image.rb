# TODO: this is different than other models in lastfm folder
# in that it's saved to database not just json convenience methods

class Lastfm::Image
  include Mongoid::Document

  field :size, type: String
  field :url, type: String

  embedded_in :event

  validates_uniqueness_of :url, scope: :size
end