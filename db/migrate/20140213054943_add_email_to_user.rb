class AddEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_cache, :string
  end
end
