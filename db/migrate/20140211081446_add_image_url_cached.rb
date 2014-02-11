class AddImageUrlCached < ActiveRecord::Migration
  def change
    add_column :artists, :image_url_cached, :string
    add_column :events, :image_url_cached, :string
    add_column :venues, :image_url_cached, :string
  end
end
