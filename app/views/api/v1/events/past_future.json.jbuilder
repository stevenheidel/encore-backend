json.events do
  json.past do
    json.partial! 'events', events: @events_past
  end

  json.future do
    json.partial! 'events', events: @events_future
  end
end