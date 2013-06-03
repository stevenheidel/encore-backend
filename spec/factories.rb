FactoryGirl.define do
  factory :concert do
    name      "How To Destroy Angels"
    date      DateTime.parse("April 25 2013")
    venue
  end

  factory :venue do
    name      "Sound Academy"
    location  "Toronto"
  end
end