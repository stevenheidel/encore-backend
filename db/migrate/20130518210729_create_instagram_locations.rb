class CreateInstagramLocations < ActiveRecord::Migration
  def change
    create_table :instagram_locations do |t|

      t.timestamps
    end
  end
end
