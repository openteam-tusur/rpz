class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.references :education
      t.string :kind
      t.string :title

      t.timestamps
    end
    add_index :checks, :education_id
  end
end
