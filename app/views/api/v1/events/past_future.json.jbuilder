json.events do
  json.past do
    json.partial! 'api/v1/events/events', events: @events_past
  end

  json.future do
    json.partial! 'api/v1/events/events', events: @events_future
  end
end