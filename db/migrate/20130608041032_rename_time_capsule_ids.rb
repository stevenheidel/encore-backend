class RenameTimeCapsuleIds < ActiveRecord::Migration
  def change
    rename_column :instagram_photos, :time_capsule_id, :concert_id
    rename_column :user_photos, :time_capsule_id, :concert_id
  end
end
