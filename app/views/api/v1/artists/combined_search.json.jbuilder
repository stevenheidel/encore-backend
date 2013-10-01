json.artist do
  json.extract! @artist, :name, :lastfm_id, :image_url if @artist.present?
end

json.others do
  json.array! @others do |other|
    json.name other.name
    json.lastfm_id other.name
  end
end

json.events do
  json.partial! 'api/v1/events/events', events: @events
end