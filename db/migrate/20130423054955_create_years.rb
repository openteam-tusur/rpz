class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.string :title

      t.timestamps
    end
  end
end
