class AddEventCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :events_count, :integer, default: 0
  end
end
