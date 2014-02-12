class AddMoreIndexes < ActiveRecord::Migration
  def change
    add_index :events, :start_date
    add_index :events, :users_count
    add_index :events, :venue_id

    add_index :flickr_photos, :event_id

    add_index :friend_visitors, :user_id
    add_index :friend_visitors, :friend_id
    add_index :friend_visitors, :event_id

    add_index :instagram_locations, :venue_id

    add_index :instagram_photos, :event_id

    add_index :lastfm_images, [:lastfm_imageable_id, :lastfm_imageable_type], name: 'index_lastfm_images_on_imageable_id_and_imageable_type'

    add_index :users, :events_count

    add_index :venues, :latitude
    add_index :venues, :longitude
  end
end
