class CreateGroupSemesters < ActiveRecord::Migration
  def change
    create_table :group_semesters do |t|
      t.references :group
      t.references :starts_on_week
      t.references :breaks_on_week
      t.references :ends_on_week
      t.references :semester

      t.timestamps
    end
    add_index :group_semesters, :group_id
    add_index :group_semesters, :starts_on_week_id
    add_index :group_semesters, :breaks_on_week_id
    add_index :group_semesters, :ends_on_week_id
    add_index :group_semesters, :semester_id
  end
end
