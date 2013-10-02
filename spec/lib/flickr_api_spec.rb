require 'flickr_api'

describe FlickrAPI, vcr: true do
  let(:event) { FactoryGirl.create :rolling_stones }

  it "should test some methods" do
    FlickrAPI.machine_tag_search("lastfm:event=3413464").count.should == 58
  end
end