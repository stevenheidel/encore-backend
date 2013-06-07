object @concert

attributes :id => :server_id
attributes :name, :date

node :venue_name do |c|
  c.venue.name
end