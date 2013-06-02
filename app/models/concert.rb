# == Schema Information
#
# Table name: concerts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  venue_id   :integer
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

class Concert < ActiveRecord::Base
  has_one :time_capsule # may be changed to has_many later
  has_one :venue
end
