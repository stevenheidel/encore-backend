class CreateFlickrPhotos < ActiveRecord::Migration
  def change
    create_table :flickr_photos do |t|
      t.integer :flickr_uuid, :limit => 8
      t.string :flickr_secret
      t.string :link
      t.string :image_url
      t.integer :concert_id
      t.string :title
      t.text :description
      t.string :user_name
      t.string :user_uuid

      t.timestamps
    end
    add_index :flickr_photos, :flickr_uuid
  end
end
