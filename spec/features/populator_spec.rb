require 'spec_helper'

feature 'The populator page', :vcr do
  before do
    visit '/time_capsules/new'
  end

  scenario 'performs searches and displays results' do
    fill_in "concert_name", with: 'How To Destroy Angels'
    fill_in "concert_date", with: 'April 25 2013'

    #fill_in "venue_name", with: 'Sound Academy'
    fill_in "city", with: 'Toronto'

    click_button "Search"

    
  end
end