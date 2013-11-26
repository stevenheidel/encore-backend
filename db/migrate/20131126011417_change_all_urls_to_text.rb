class ChangeAllUrlsToText < ActiveRecord::Migration
  def change
  	change_column :artists, :website, :text

  	change_column :events, :website, :text

  	change_column :venues, :website, :text
  end
end
