# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  latitude   :decimal(, )
#  longitude  :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#

class Venue < ActiveRecord::Base
  belongs_to :concert
end
