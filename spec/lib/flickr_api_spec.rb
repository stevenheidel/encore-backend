require 'flickr_api'

describe FlickrAPI, :vcr do
  let(:concert) { FactoryGirl.create :concert,
    name: "Rolling Stones",
    start_time: "May 25, 2013 15:00",
    end_time: "May 25, 2013 21:00",
    venue: FactoryGirl.create(:venue,
      name: "Air Canada Centre",
      latitude: 43.6437852,
      longitude: -79.3784416,
      location: "Toronto") }

  it "should test some methods" do
    FlickrAPI.test(concert)
  end
end