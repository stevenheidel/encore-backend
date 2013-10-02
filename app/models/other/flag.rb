# == Schema Information
#
# Table name: flags
#
#  id         :uuid             not null, primary key
#  type       :string(255)
#  user_id    :uuid
#  post_id    :uuid
#  created_at :datetime
#  updated_at :datetime
#

class Other::Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
