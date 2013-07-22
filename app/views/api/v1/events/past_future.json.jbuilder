json.events do
  json.past do
    json.partial! 'events', events: @events
  end

  json.future do
    json.partial! 'events', events: @events
  end
end