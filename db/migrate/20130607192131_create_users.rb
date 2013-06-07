class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :facebook_uuid
      t.string :oauth_string
      t.datetime :oauth_expirty
      t.string :name

      t.timestamps
    end
    add_index :users, :facebook_uuid, unique: true
  end
end
