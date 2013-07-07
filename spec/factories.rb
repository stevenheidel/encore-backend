FactoryGirl.define do
  factory :artist do
    lastfm_id "Cher"
    name "Cher"
  end
  
  factory :event do
    name "Event Name"

    factory :past_event do
      association :venue, lastfm_id: "543"
      lastfm_id "54321" # TODO: automatically deal with unique lastfm_id's
      start_date "Fri, 28 Aug 2009 04:42:01"
    end

    factory :future_event do
      association :venue, lastfm_id: "123"
      lastfm_id "12345"
      start_date "Fri, 28 Aug 2014 04:42:01"
    end

    factory :rolling_stones do
      name "Rolling Stones"
      association :venue, factory: :air_canada_centre
      lastfm_id "11111"
      start_date "May 25, 2013 15:00"
    end
  end

  factory :venue do
    lastfm_id "123"
    name "Venue name"

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
end