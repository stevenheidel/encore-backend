require 'echonest_api'

describe EchonestAPI, :vcr do
  it "should do a search" do
    EchonestAPI.suggest("rad")
  end

  it "should get songkick id from echonest id" do
    EchonestAPI.get_songkick_id(EchonestAPI.suggest("rad")[0].id).should == 253846
  end
end