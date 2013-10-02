class CreateConcerts < ActiveRecord::Migration
  enable_extension 'uuid-ossp'

  def change
    create_table :instagram_location, id: :uuid do |t|
      t.string :name
      t.integer :instagram_uuid

      t.uuid :venue_id

      t.timestamps
    end
  end

  def change
    create_table :lastfm_image, id: :uuid do |t|
      t.string :size
      t.string :url

      t.uuid :lastfm_imageable_id
      t.string :lastfm_imageable_type

      t.timestamps
    end
end