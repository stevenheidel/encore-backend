json.name @artist.name

json.events do
  json.past do
    json.partial! 'api/v1/events/events', events: @past_events
  end
  json.upcoming do
    json.partial! 'api/v1/events/events', events: @upcoming_events
  end
end
