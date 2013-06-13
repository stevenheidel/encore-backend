class RemoveEventfulIdFromConcert < ActiveRecord::Migration
  def change
    remove_column :concerts, :eventful_id
    add_column :concerts, :songkick_id, :integer
  end
end
