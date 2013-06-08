require 'eventful_api'

describe EventfulAPI, :vcr do
  describe '.full_search' do
    it 'should do a sample search that returns one result' do
      result = EventfulAPI.full_search("How To Destroy Angels", "Toronto", "April 25, 2013")
    end

    it 'should do a sample search that returns multiple results' do
      #result = EventfulAPI.venue_search("Rogers Centre", "Toronto")
    end
  end
end