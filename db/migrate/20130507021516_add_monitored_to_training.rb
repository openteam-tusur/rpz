class AddMonitoredToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :monitored, :boolean, :default => false
  end
end
