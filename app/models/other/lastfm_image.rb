# == Schema Information
#
# Table name: lastfm_images
#
#  id                    :uuid             not null, primary key
#  size                  :string(255)
#  url                   :string(255)
#  lastfm_imageable_id   :uuid
#  lastfm_imageable_type :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class Other::LastfmImage < ActiveRecord::Base
  belongs_to :lastfm_imageable, polymorphic: true

  #validates_uniqueness_of :url, scope: :size
end
