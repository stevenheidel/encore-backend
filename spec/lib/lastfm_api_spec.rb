require 'lastfm_api'

describe LastfmAPI, :vcr do
  it "artist.getPastEvents_all" do
    pp LastfmAPI.artist_getPastEvents_all("The Rolling Stones")
  end
end