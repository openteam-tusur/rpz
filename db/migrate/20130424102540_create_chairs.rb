class CreateChairs < ActiveRecord::Migration
  def change
    create_table :chairs do |t|
      t.text :title
      t.string :abbr
      t.string :slug

      t.timestamps
    end
  end
end
