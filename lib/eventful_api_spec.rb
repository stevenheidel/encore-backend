require 'spec_helper'

describe EventfulAPI, :vcr do
  describe '.url' do 
    it 'should return the right url' do
      EventfulAPI.url.should == 'http://api.eventful.com/json/events/search?app_key=2J3KXtGbfVvkp3ZZ'
    end
  end

  describe '.search' do
    it 'should do a sample search' do
      result = EventfulAPI.search("How To Destroy Angels", "Toronto", "April 25, 2013")
    
      result.title.should == "How To Destroy Angels"
    end
  end
end