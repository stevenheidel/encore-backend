class AddPastEventFreshnessToArtist < ActiveRecord::Migration
  def change
  	add_column :artists, :past_event_freshness, :datetime, default: nil
  end
end
