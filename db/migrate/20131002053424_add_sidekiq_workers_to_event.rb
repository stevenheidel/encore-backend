class AddSidekiqWorkersToEvent < ActiveRecord::Migration
  def change
    add_column :events, :sidekiq_workers, :string, array: true, default: []
  end
end
