class AddYearToFaculty < ActiveRecord::Migration
  def change
    add_column :faculties, :year_id, :integer
    add_index :faculties, :year_id
  end
end
