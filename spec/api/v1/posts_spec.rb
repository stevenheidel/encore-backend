require 'spec_helper'

describe "/api/v1/concerts/:concert_id/posts", :type => :api do
  let(:concert) { FactoryGirl.create :concert }
  let(:user)    { FactoryGirl.create :user }
  let(:url)     { "/api/v1/concerts/#{concert.songkick_uuid}/posts" }
  let(:file)    { "spec/fixtures/files/profile.jpg" }

  context "POST to add new photos" do
    it "post to the URL" do
      pending "don't upload to Rackspace all the time"
      post url, {
        image: Rack::Test::UploadedFile.new(file, "image/jpeg"),
        facebook_id: user.facebook_uuid
      }

      UserPhoto.first.photo.url
    end
  end
end