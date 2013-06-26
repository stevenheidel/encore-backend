class ChangeUserPhotoIdsToIntegers < ActiveRecord::Migration
  def change
    change_column :user_photos, :concert_id, :integer
    change_column :user_photos, :user_id, :integer
  end
end
