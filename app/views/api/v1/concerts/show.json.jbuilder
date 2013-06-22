json.songkick_id @concert.songkick_uuid
json.extract! @concert, :name, :date
json.venue_name @concert.venue.name