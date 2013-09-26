require 'spec_helper'
require 'facebook_api'

describe FacebookAPI, vcr: { record: :once, re_record_interval: nil } do
  it "should retrieve public info on user" do
    user_info = FacebookAPI.get_public_info("696955405")
    user_info.should_not be_nil
    user_info["id"].should == "696955405"
    user_info["name"].should == "Steven Heidel"
  end

  it "should return nil if not found" do
    user_info = FacebookAPI.get_public_info("34567890")
    user_info.should be_nil
  end
end