class ChangeFlickrUuidToString < ActiveRecord::Migration
  def change
    change_column :flickr_photos, :flickr_uuid, :string
  end
end
