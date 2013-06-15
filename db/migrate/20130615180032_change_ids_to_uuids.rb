class ChangeIdsToUuids < ActiveRecord::Migration
  def change
    rename_column :venues, :songkick_id, :songkick_uuid

    rename_column :instagram_photos, :instagram_id, :instagram_uuid
    rename_column :instagram_photos, :user_id, :user_uuid

    rename_column :concerts, :songkick_id, :songkick_uuid

    rename_column :artists, :songkick_id, :songkick_uuid

    rename_column :instagram_locations, :instagram_id, :instagram_uuid
  end
end
