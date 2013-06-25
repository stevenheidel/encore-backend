require 'spec_helper'

describe "/api/v1/users", :type => :api do
  context "logging in a user" do
    let(:url) { "/api/v1/users" }
    let(:params) { {"expiration_date" => "2013-08-02T02:53:23Z",
        "oauth" => "CAACp5xj4c9sBAIeNLxb3204nzPOYmPoQdPbMKRAosUQpmdrRAJ1VTMDZC4XH6zXe8KZCXAHdD7aTDX67gy9ysmOZAgljhlQpzFB7fmw9KGAJJgig84x7xwoeAjIKgoEphm3iq0t31Vq2814uxqQgWDNQDXl00DkegO5tvGE2wZDZD",
        "facebook_id" => "1651770074",
        "name" => "Steven Heidel"} }

    it "should be successful for a brand new user" do
      post url, params

      assert last_response.ok?
      last_response.body.should == '{"response":"success"}'

      (u = User.where(:facebook_uuid => 1651770074)).count.should == 1
      u.first.oauth_expiry.should == DateTime.parse("2013-08-02T02:53:23Z")
    end

    it "should be successful for a current user" do
      5.times { post url, params }

      assert last_response.ok?

      (u = User.where(:facebook_uuid => 1651770074)).count.should == 1
    end
  end
end