require 'spec_helper'

describe "/api/v1/artists/:artist_id/concerts/past", type: :api, vcr: true do
  let(:url) { "/api/v1/artists/276130/concerts/past" } #276130 is AC/DC

  it "should return past concerts" do
    get url, {city: 'Toronto'}

    pp last_response.body
  end
end