require 'spec_helper.rb'
require 'youtube_api'

describe YoutubeAPI do
  it 'should return some artists' do
     YoutubeAPI.search("Beyonce", "Texas").should_not be_empty
 end
end

describe YoutubeAPI do
 it 'should have the correct artists' do
  	YoutubeAPI.search("MGMT", "Paris").each do |item|
  		item.title.should include("MGMT")
  	end
  end
end

describe YoutubeAPI do
  it 'city and artist should be correct' do
     YoutubeAPI.search("ACDC", "Sydney").each do |item|
  		item.title.should include("ACDC", "Sydney")
  	end
 end
end