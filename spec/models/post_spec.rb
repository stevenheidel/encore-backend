require 'spec_helper'

describe Post, :vcr do
  let(:post) { FactoryGirl.create :post }

  it "should add a flag to a post" do
    post.add_flag("Not relevant", 696955405)

    pp post.flags
  end
end