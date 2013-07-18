require 'instagram_api'

describe InstagramAPI, :vcr do
  let(:event) { FactoryGirl.create :rolling_stones }

  it "should test some methods" do
    #InstagramAPI.location_search(43.643929, -79.379305).should include("Air Canada")

    InstagramAPI.location_recent_media(35940, event.start_time, event.end_time).data
  end
end