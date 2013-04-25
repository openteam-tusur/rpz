class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.references :group_semester
      t.references :discipline
      t.references :chair
      t.string :cycle_code
      t.text :cycle_title

      t.timestamps
    end
    add_index :educations, :group_semester_id
    add_index :educations, :discipline_id
    add_index :educations, :chair_id
  end
end
