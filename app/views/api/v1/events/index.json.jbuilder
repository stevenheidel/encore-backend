json.events do
  json.partial! 'api/v1/events/events', events: @events
end