json.total @events_total_count
json.events do
  json.partial! 'api/v1/events/events', events: @events
end