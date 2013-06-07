class AddArtistIdToConcert < ActiveRecord::Migration
  def change
    add_column :concerts, :artist_id, :integer
  end
end
