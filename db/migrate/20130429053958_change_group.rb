class ChangeGroup < ActiveRecord::Migration
  def up
    remove_column :groups, :faculty_id
    add_column :groups, :course_id, :integer
    add_index :groups, :course_id
  end

  def down
    remove_index :groups, :course_id
    remove_column :groups, :course_id
    add_column :groups, :faculty_id, :integer
  end
end
