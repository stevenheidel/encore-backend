class ChangeEventfulIDsToStrings < ActiveRecord::Migration
  def change
    change_column :concerts, :eventful_id, :string
    change_column :venues, :eventful_id, :string
  end
end
