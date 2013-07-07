shared_examples "lastfmable" do
  let(:model) { FactoryGirl.create described_class.name.downcase }

  describe "#get" do
    it "should return it if it exists" do
      described_class.get(model.lastfm_id).should == model
    end
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