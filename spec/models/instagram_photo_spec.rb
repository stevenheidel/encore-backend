# == Schema Information
#
# Table name: instagram_photos
#
#  id                   :integer          not null, primary key
#  instagram_id         :string(255)
#  caption              :text
#  link                 :string(255)
#  image_url            :string(255)
#  time_capsule_id      :integer
#  user_name            :string(255)
#  user_profile_picture :string(255)
#  user_id              :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe InstagramPhoto do
  #pending "add some examples to (or delete) #{__FILE__}"
end
