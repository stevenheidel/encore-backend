class AddNameToInstagramLocation < ActiveRecord::Migration
  def change
    add_column :instagram_locations, :name, :string
  end
end
