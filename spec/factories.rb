FactoryGirl.define do
  # CONCERT
  factory :concert do
    name      "How To Destroy Angels"
    date      DateTime.parse("April 25 2013")
    start_time  DateTime.parse("April 25, 2013 16:00")
    end_time  DateTime.parse("April 25, 2013 22:00")
    songkick_uuid 15782629
    venue
  end

  factory :rolling_stones, class: Concert do
    name "Rolling Stones"
    start_time "May 25, 2013 15:00"
    end_time "May 25, 2013 21:00"
    association :venue, factory: :air_canada_centre
  end

  # VENUE
  factory :venue do
    name      "Sound Academy"
    location  "Toronto"
    latitude  43.6413958
    longitude -79.3543721
  end

  factory :air_canada_centre, class: Venue do
    name "Air Canada Centre"
    latitude 43.6437852
    longitude -79.3784416
    location "Toronto"
  end

  # USER
  factory :user do
    name "Steven Heidel"
    facebook_uuid 696955405
  end
end