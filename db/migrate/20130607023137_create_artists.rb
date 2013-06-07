class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :songkick_id

      t.timestamps
    end
  end
end
