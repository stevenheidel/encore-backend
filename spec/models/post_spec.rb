require 'spec_helper'

describe Post, :vcr do
  let(:post) { FactoryGirl.create :post }

  it "should add a flag to a post" do
    post.add_flag("Not relevant", 696955405)

    post.flags.count.should == 1
  end
end