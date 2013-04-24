class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.string :title
      t.string :abbr
      t.string :slug

      t.timestamps
    end
  end
end
