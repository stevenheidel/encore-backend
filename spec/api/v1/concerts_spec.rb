require 'spec_helper'

describe "/api/v1/artists/:artist_id/concerts/past", type: :api, vcr: true do
  context "past" do
    let(:url) { "/api/v1/artists/276130/concerts/past.json" } #276130 is AC/DC

    it "should return past concerts" do
      get url, {city: 'Toronto'}

      last_response.body
    end
  end

  context "create" do
    let(:concert) { FactoryGirl.create :concert }
    let(:user) { FactoryGirl.create :user }
    let(:url) { "/api/v1/users/#{user.id}/concerts" }

    it "should add a concert to a user" do
      p url
    end
  end
end