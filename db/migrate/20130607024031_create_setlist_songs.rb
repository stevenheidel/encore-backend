class CreateSetlistSongs < ActiveRecord::Migration
  def change
    create_table :setlist_songs do |t|
      t.string :name
      t.string :itunes_link
      t.string :concert_id

      t.timestamps
    end
  end
end
