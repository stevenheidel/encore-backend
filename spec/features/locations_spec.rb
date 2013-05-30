require 'spec_helper'

feature 'The locations page', :vcr do
  before do
    visit '/locations'
  end

  scenario 'displays a list of locations from Instagram' do
    fill_in "latitude", with: '43.653226'
    fill_in "longitude", with: '-79.383184'
    click_button "Search"

    locations = all '#locations p'
    locations.should_not be_empty

    page.should have_content "City Hall"
  end
end