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

require 'spec_helper'

describe Attendance do
  #pending "add some examples to (or delete) #{__FILE__}"
end
