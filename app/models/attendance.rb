# == Schema Information
#
# Table name: attendances
#
#  id           :integer          not null, primary key
#  concert_id   :integer
#  user_id      :integer
#  who_referred :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Attendance < ActiveRecord::Base
  belongs_to :concert
  belongs_to :user
end
