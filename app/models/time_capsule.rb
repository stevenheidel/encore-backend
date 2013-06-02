# == Schema Information
#
# Table name: time_capsules
#
#  id         :integer          not null, primary key
#  populated  :boolean
#  concert_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class TimeCapsule < ActiveRecord::Base
  belongs_to :concert
end
