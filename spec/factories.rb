FactoryGirl.define do
  factory :concert do
    name      "How To Destroy Angels"
    date      DateTime.parse("April 25 2013")
    start_time  DateTime.parse("April 25, 2013 16:00")
    end_time  DateTime.parse("April 25, 2013 22:00")
    songkick_uuid 15782629
    venue
  end

  factory :venue do
    name      "Sound Academy"
    location  "Toronto"
    latitude  43.6413958
    longitude -79.3543721
  end

  factory :user do
    name "Steven Heidel"
    facebook_uuid 696955405
  end
end