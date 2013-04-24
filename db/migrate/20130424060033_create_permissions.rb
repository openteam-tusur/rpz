class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user
      t.references :faculty
      t.string :role
      t.timestamps
    end
    add_index :permissions, [:user_id, :role, :faculty_id], :name => 'by_user_and_role_and_faculty'
  end
end
