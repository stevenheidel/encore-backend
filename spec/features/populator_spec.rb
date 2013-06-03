require 'spec_helper'

feature 'The populator page', :vcr do
  before do
    visit '/time_capsules/new'
  end

  scenario 'displays a list of sample images from Instagram' do
    fill_in "concert_name", with: 'Sensation'
    fill_in "concert_date", with: 'June 01 2013'

    fill_in "venue_name", with: 'Rogers Centre'
    fill_in "venue_location", with: 'Toronto'

    click_button "Populate"

    photos = all '#photos p'
    photos.should_not be_empty

    page.should have_content "http://instagram.com/p/YiwNpiNycl/"
  end
end