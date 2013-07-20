FactoryGirl.define do
  factory :artist do
    lastfm_id "Cher"
    name "Cher"

    factory :the_rolling_stones do
      lastfm_id "The Rolling Stones"
      name "The Rolling Stones"
    end
  end
  
  factory :event do
    name "Event Name"
    lastfm_id "12345"
    association :venue, lastfm_id: "123"

    factory :past_event do
      lastfm_id "54321" # TODO: automatically deal with unique lastfm_id's
      start_date "Fri, 28 Aug 2009 04:42:01"
    end

    factory :future_event do
      lastfm_id "12345"
      start_date "Fri, 28 Aug 2014 04:42:01"
    end

    factory :rolling_stones do
      name "Rolling Stones"
      association :venue, factory: :air_canada_centre
      lastfm_id "3559569"
      flickr_tag "lastfm:event=3559569"
      start_date "June 07, 2013 00:00" # in UTC
    end
  end

  factory :venue do
    lastfm_id "12349"
    name "Massey Hall"
    city "Toronto"

    factory :air_canada_centre do
      name "Air Canada Centre"
      lastfm_id 8781753
      latitude 43.643929
      longitude -79.379305
    end
  end

  factory :user do
    name "Steven Heidel"
    facebook_id 696955405

    factory :with_events do
      events {[
        create(:past_event),
        create(:future_event)
      ]}
    end
  end

  factory :post do
  end
end