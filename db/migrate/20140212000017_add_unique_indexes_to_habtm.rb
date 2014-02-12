class AddUniqueIndexesToHabtm < ActiveRecord::Migration
  def change
    remove_index :artists_events, [:artist_id, :event_id]
    add_index :artists_events, [:artist_id, :event_id], unique: true

    remove_index :events_users, [:event_id, :user_id]
    add_index :events_users, [:event_id, :user_id], unique: true
  end
end
