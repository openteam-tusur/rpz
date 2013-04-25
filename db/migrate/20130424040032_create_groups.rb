class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :faculty
      t.references :year
      t.string :number
      t.integer :year_forming
      t.integer :course
      t.integer :budget_students_count
      t.integer :payment_students_count

      t.timestamps
    end
    add_index :groups, :faculty_id
  end
end
