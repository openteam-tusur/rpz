class CreateLoadings < ActiveRecord::Migration
  def change
    create_table :loadings do |t|
      t.references :week
      t.references :training
      t.integer :value

      t.timestamps
    end
    add_index :loadings, :week_id
    add_index :loadings, :training_id
  end
end
