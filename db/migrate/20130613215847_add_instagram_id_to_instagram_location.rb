class AddInstagramIdToInstagramLocation < ActiveRecord::Migration
  def change
    add_column :instagram_locations, :instagram_id, :integer
  end
end
