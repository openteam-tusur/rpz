class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.text :title

      t.timestamps
    end
  end
end
