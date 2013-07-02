require 'lastfm_api'

describe LastfmAPI, :vcr do
  it "artist.getPastEvents_all" do
    LastfmAPI.artist_getPastEvents_all("The Rolling Stones")
  end
end