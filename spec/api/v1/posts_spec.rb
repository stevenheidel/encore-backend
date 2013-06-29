require 'spec_helper'

describe "/api/v1/concerts/:concert_id/posts", :type => :api do
  let(:concert) { FactoryGirl.create :concert }
  let(:url)     { "/api/v1/concerts/#{concert.songkick_uuid}/posts" }
  let(:file)    { "spec/fixtures/files/profile.jpg" }

  context "POST to add new photos" do
    it "post to the URL" do
      post url, "image" => Rack::Test::UploadedFile.new(file, "image/jpeg")

      UserPhoto.first.photo.url
    end
  end
end