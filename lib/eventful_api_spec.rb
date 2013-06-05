#require 'spec_helper'

require 'eventful_api'

describe EventfulAPI, :vcr do
  # TODO get rid of
  describe '.url' do 
    it 'should return the right url' do
      EventfulAPI.url.should == 'http://api.eventful.com/json/events/search?app_key=2J3KXtGbfVvkp3ZZ'
    end
  end

  # TODO get rid of
  describe '.event_search' do
    it 'should do a sample search' do
      result = EventfulAPI.event_search("How To Destroy Angels", "Toronto", "April 25, 2013")
    
      result.title.should == "How To Destroy Angels"
    end
  end

  # TODO get rid of
  describe '.venue_search' do
    it 'should do a sample search that returns one result' do
      result = EventfulAPI.venue_search("Sound Academy", "Toronto")
    
      result.name.should == "Sound Academy"
    end

    it 'should do a sample search that returns multiple results' do
      result = EventfulAPI.venue_search("Rogers Centre", "Toronto")
      
      result.name.should include("Rogers Centre")
    end
  end

  describe '.full_search' do
    it 'should do a sample search that returns one result' do
      result = EventfulAPI.full_search("How To Destroy Angels", "Toronto", "April 25, 2013")
      pp result
    end

    it 'should do a sample search that returns multiple results' do
      #result = EventfulAPI.venue_search("Rogers Centre", "Toronto")
    end
  end
end