class AddPrecisionAndScaleToLatitudeAndLongitude < ActiveRecord::Migration
  def change
    change_column :venues, :latitude, :decimal, precision: 10, scale: 6
    change_column :venues, :longitude, :decimal, precision: 10, scale: 6
  end
end
