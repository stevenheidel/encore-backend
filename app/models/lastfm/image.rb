class Lastfm::Image
  include Mongoid::Document

  field :size, type: String
  field :url, type: String

  embedded_in :concert
end