class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :number
      t.references :year
      t.references :semester
      t.date :starts_on

      t.timestamps
    end
    add_index :weeks, :year_id
    add_index :weeks, :semester_id
  end
end
