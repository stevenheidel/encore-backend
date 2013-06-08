class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.string :time_capsule_id
      t.string :user_id

      t.timestamps
    end
  end
end
