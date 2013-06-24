# == Schema Information
#
# Table name: concerts
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  venue_id      :integer
#  date          :date
#  created_at    :datetime
#  updated_at    :datetime
#  start_time    :datetime
#  end_time      :datetime
#  artist_id     :integer
#  populated     :boolean
#  songkick_uuid :integer
#

require 'spec_helper'

describe Concert do
  let(:concert) { FactoryGirl.create :concert, 
    start_time: nil, end_time: nil }

  it "should fake the start time and end time" do
    concert.date.should == DateTime.parse("April 25 2013")
    concert.start_time.should == DateTime.parse("April 25 2013 18:00")
    concert.end_time.should == DateTime.parse("April 26 2013 00:00")
  end
end
