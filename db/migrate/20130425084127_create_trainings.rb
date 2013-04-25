class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.references :education
      t.string :kind
      t.string :title
      t.integer :planned_loading

      t.timestamps
    end
    add_index :trainings, :education_id
  end
end
