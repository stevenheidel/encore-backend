# == Schema Information
#
# Table name: venues
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  latitude      :decimal(10, 6)
#  longitude     :decimal(10, 6)
#  created_at    :datetime
#  updated_at    :datetime
#  location      :string(255)
#  songkick_uuid :integer
#

require 'spec_helper'

describe Venue do
  #pending "add some examples to (or delete) #{__FILE__}"
end
