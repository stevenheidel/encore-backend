require 'spec_helper'

describe Post::InstagramPhoto do
  it "should insert crazy UTF8 4 byte characters" do
    ip = Post::InstagramPhoto.new
    ip.caption = "MADONNA!!!!!!  Other: \xF0\x9F\x8E\xB6"
    ip.save

    Post::InstagramPhoto.first.caption.should == "MADONNA!!!!!!  Other: "
  end
end
