class ChangeSidekiqWorkerTypeToString < ActiveRecord::Migration
  def change
    change_column :events, :sidekiq_workers, :text
    Event.connection.execute('ALTER TABLE events ALTER COLUMN sidekiq_workers DROP DEFAULT')
  end
end
