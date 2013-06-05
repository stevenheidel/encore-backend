class AddEventfulIdToConcertAndVenue < ActiveRecord::Migration
  def change
    add_column :concerts, :eventful_id, :integer
    add_column :venues, :eventful_id, :integer
  end
end
