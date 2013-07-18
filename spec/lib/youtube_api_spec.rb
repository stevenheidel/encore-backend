require 'youtube_api'

describe YoutubeAPI, :vcr do
  it 'should test some methods' do
    YoutubeAPI.search("Beyonce").should_include == "Beyonce"
  end
end