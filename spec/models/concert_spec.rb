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

require 'spec_helper'

describe Concert do
  #pending "add some examples to (or delete) #{__FILE__}"
end
