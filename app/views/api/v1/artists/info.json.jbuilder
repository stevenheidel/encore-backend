json.name @artist.name

json.events do
  json.past do
    json.partial! 'api/v1/events/events', events: @past_events if @past_events.is_a?(Array)
  end
  json.upcoming do
    json.partial! 'api/v1/events/events', events: @upcoming_events if @upcoming_events.is_a?(Array)
  end
end
