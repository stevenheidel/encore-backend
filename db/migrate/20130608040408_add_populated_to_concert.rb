class AddPopulatedToConcert < ActiveRecord::Migration
  def change
    add_column :concerts, :populated, :boolean
  end
end
