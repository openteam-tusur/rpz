class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :faculty
      t.integer :number

      t.timestamps
    end
    add_index :courses, :faculty_id
  end
end
