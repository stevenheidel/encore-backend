require 'lastfm_api'

describe LastfmAPI, :vcr do
  it "artist.getPastEvents_all" do
    pp LastfmAPI.event_getInfo(1622934)
  end
end