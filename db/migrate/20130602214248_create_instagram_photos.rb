class CreateInstagramPhotos < ActiveRecord::Migration
  def change
    create_table :instagram_photos do |t|
      t.string :instagram_id
      t.text :caption
      t.string :link
      t.string :image_url
      t.integer :time_capsule_id
      t.string :user_name
      t.string :user_profile_picture
      t.string :user_id

      t.timestamps
    end
  end
end
