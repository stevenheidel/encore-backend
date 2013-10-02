class Other::LastfmImage < ActiveRecord::Base
  belongs_to :lastfm_imageable

  validates_uniqueness_of :url, scope: :size
end