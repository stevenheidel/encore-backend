class AddUniqueIndexesToHabtm < ActiveRecord::Migration
  def change
    add_index :artists_events, [:artist_id, :event_id], unique: true
    add_index :artists_events, :event_id # only for second one according to https://stackoverflow.com/questions/15210639/need-two-indexes-on-a-habtm-join-table

    add_index :events_users, [:event_id, :user_id], unique: true
    add_index :events_users, :user_id
  end
end
