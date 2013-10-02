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

require 'spec_helper'

describe Other::LastfmImage do
  pending "add some examples to (or delete) #{__FILE__}"
end
