class RemoveFacultyIdFromPermissions < ActiveRecord::Migration
  def up
    remove_column :permissions, :faculty_id
  end

  def down
    add_column :permissions, :faculty_id, :integer
  end
end
