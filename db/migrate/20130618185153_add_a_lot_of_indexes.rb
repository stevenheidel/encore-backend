class AddALotOfIndexes < ActiveRecord::Migration
  def change
    # Relational indexes
    add_index :attendances, :concert_id
    add_index :attendances, :user_id

    add_index :concerts, :venue_id
    add_index :concerts, :artist_id

    add_index :instagram_locations, :venue_id

    add_index :instagram_photos, :concert_id

    add_index :setlist_songs, :concert_id

    add_index :user_photos, :concert_id
    add_index :user_photos, :user_id

    # UUID indexes
    add_index :artists, :songkick_uuid
    add_index :concerts, :songkick_uuid
    add_index :venues, :songkick_uuid

    add_index :instagram_locations, :instagram_uuid
    add_index :instagram_photos, :instagram_uuid
  end
end
