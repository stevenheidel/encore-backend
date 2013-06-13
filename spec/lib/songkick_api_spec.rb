require 'songkick_api'

describe SongkickAPI, :vcr do
  it 'should test some methods' do
    SongkickAPI.artist_search("Radiohead").first.displayName.should == "Radiohead"
    SongkickAPI.artist_gigography(253846).count.should == 50
    SongkickAPI.artist_gigography(253846, true).count.should == 999
    SongkickAPI.get_event_by_id(3037536)
  end
end