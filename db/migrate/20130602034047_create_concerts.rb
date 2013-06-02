class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :name
      t.integer :venue_id
      t.date :date

      t.timestamps
    end
  end
end
