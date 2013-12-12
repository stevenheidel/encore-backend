class AddUniqueIndexes < ActiveRecord::Migration
  def change
  	add_index :artists, :lastfm_id, unique: true
  	add_index :events, :lastfm_id, unique: true
  	add_index :venues, :lastfm_id, unique: true

  	add_index :users, :facebook_id, unique: true
  end
end