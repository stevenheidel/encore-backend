require 'spec_helper'

describe InstagramLocation do
  describe '.search' do
    before do
      locations = [
        {}
      ]
      Instagram::Location.should_receive(:search).and_return(locations)


    end
  end
end
