class AddVenueIdToInstagramLocation < ActiveRecord::Migration
  def change
    add_column :instagram_locations, :venue_id, :integer
  end
end
