require 'flickr_api'

describe FlickrAPI, vcr: false do
  let(:event) { FactoryGirl.create :rolling_stones }

  pending "should test some methods" do
    FlickrAPI.machine_tag_search("lastfm:event=3413464").count.should > 50
  end
end