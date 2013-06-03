# == Schema Information
#
# Table name: instagram_locations
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  venue_id   :integer
#

require 'spec_helper'

describe InstagramLocation do
  describe '.search' do
    before do
      locations = [
        {}
      ]
      #InstagramLocation.should_receive(:search).and_return(locations)
    end

    it '' do

    end
  end
end
