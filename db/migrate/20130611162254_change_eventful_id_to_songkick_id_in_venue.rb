class ChangeEventfulIdToSongkickIdInVenue < ActiveRecord::Migration
  def change
    remove_column :venues, :eventful_id
    add_column :venues, :songkick_id, :integer
  end
end
