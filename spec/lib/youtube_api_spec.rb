require 'youtube_api'

describe YoutubeAPI, :vcr do
  it 'should return some videos' do
    YoutubeAPI.search("Query").count.should == 10
  end
end