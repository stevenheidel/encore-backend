# == Schema Information
#
# Table name: concerts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  venue_id    :integer
#  date        :date
#  created_at  :datetime
#  updated_at  :datetime
#  start_time  :datetime
#  end_time    :datetime
#  eventful_id :string(255)
#  artist_id   :integer
#

require 'spec_helper'

describe Concert do
  #pending "add some examples to (or delete) #{__FILE__}"
end
