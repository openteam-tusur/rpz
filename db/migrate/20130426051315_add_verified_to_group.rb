class AddVerifiedToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :verified, :boolean, :default => false
  end
end
