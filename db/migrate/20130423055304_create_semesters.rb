class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :title
      t.references :year
      t.date :starts_on
      t.date :ends_on
      t.date :breaks_on

      t.timestamps
    end
    add_index :semesters, :year_id
  end
end
