class AddStartAndEndTimeToConcert < ActiveRecord::Migration
  def change
    add_column :concerts, :start_time, :datetime
    add_column :concerts, :end_time, :datetime
  end
end
