require 'spec_helper'

describe Geo, :vcr do
  it "should seed the database" do
    g = Geo.get_or_set("Toronto", "Canada")
    g.city.should == "Toronto"
    g.country.should == "Canada"

    g.id.should == Geo.get_or_set("Toronto", "Canada").id

    Geo.get_or_set("Regina", "Canada").city.should == "Regina"
    Geo.get_or_set("Regina", "Canada").country.should == "Canada"
    Geo.get("Toronto").should == g
  end
end
