# == Schema Information
#
# Table name: artists
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  songkick_uuid :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Artist < ActiveRecord::Base
  has_many :concerts
end
