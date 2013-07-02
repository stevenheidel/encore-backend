json.extract! @concert, :lastfm_id, :name
# json.date :date # TODO
json.venue_name @concert.venue.name
# json.image_url # TODO