json.extract! @event, :lastfm_id, :name, :date
json.venue_name @event.venue.name
# json.image_url # TODO