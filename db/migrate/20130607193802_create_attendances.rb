class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :concert_id
      t.integer :user_id
      t.integer :who_referred

      t.timestamps
    end
  end
end
