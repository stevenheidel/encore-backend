class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :oauth_expirty, :oauth_expiry
  end
end
