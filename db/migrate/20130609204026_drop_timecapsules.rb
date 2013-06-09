class DropTimecapsules < ActiveRecord::Migration
  def change
    drop_table :time_capsules
  end
end
