require 'spec_helper'

describe Saver::Migrater, :vcr do
  it "should work on a test user" do
    Saver::Migrater.new.perform("1245647594")
  end
end