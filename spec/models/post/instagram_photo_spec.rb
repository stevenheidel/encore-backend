# == Schema Information
#
# Table name: instagram_photos
#
#  id                   :uuid             not null, primary key
#  instagram_uuid       :string(255)
#  caption              :string(255)
#  link                 :string(255)
#  image_url            :string(255)
#  user_name            :string(255)
#  user_profile_picture :string(255)
#  user_uuid            :string(255)
#  event_id             :uuid
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe Post::InstagramPhoto do
  it "should insert crazy UTF8 4 byte characters" do
    ip = Post::InstagramPhoto.new
    ip.caption = "MADONNA!!!!!!  Other: \xF0\x9F\x8E\xB6"
    ip.save

    Post::InstagramPhoto.first.caption.should == "MADONNA!!!!!!  Other: "
  end
end
