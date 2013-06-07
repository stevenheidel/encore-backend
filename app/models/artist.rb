# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  songkick_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Artist < ActiveRecord::Base
  has_many :concerts
end
