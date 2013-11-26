class ChangeEventTicketsUrlToText < ActiveRecord::Migration
  def change
  	change_column :events, :tickets_url, :text
  end
end
