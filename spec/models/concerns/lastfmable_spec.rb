shared_examples "lastfmable" do
  let!(:model) { FactoryGirl.create described_class.name.downcase }

  describe "#get" do
    it "should return it if it exists" do
      #pp described_class.all.entries
      described_class.get(model.lastfm_id).should == model
    end
  end

  describe "#find_or_create_from_lastfm" do

  end

  describe ".image_url" do
    #it "should return the largest image"
  end
end

describe Artist do
  it_behaves_like "lastfmable"
end

describe Event do
  it_behaves_like "lastfmable"
end

describe Venue do
  it_behaves_like "lastfmable"
end