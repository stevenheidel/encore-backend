require 'spec_helper'

describe Concert do
  let(:concert) { FactoryGirl.create :concert, 
    start_time: nil, end_time: nil }

  it "should fake the start time and end time" do
    pending "this will change with last.fm"
    concert.date.should == DateTime.parse("April 25 2013")
    concert.start_time.should == DateTime.parse("April 25 2013 18:00")
    concert.end_time.should == DateTime.parse("April 26 2013 00:00")
  end

  it "should get all the posts" do
    concert.posts
  end
end
