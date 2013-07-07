FactoryGirl.define do
  # ARTISTS
  factory :artist do
    lastfm_id "Cher"
    name "Cher"
  end
  
  # EVENTS
  factory :event do
    name "Event Name"

    factory :past_event do
      association :venue, lastfm_id: "543"
      lastfm_id "54321"
      start_date "Fri, 28 Aug 2009 04:42:01"
    end

    factory :future_event do
      association :venue, lastfm_id: "123"
      lastfm_id "12345"
      start_date "Fri, 28 Aug 2014 04:42:01"
    end
  end

  factory :venue do
    lastfm_id "123"
    name "Venue name"
  end

  # USERS
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