require 'foursquare_api'

describe FoursquareAPI, :vcr do
  it 'should search for a location' do
    FoursquareAPI.search_venues("Air Canada Centre", 43.6440859, -79.3783696).count.should > 0

    #FoursquareAPI.search_venues("Air Canada Center", 43.6440859, -79.3783696).each{|v| puts v.id}
  end
end