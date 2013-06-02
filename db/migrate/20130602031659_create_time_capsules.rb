class CreateTimeCapsules < ActiveRecord::Migration
  def change
    create_table :time_capsules do |t|
      t.boolean :populated
      t.integer :concert_id

      t.timestamps
    end
  end
end
