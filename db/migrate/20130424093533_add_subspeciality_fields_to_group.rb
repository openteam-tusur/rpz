class AddSubspecialityFieldsToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :subspeciality_id, :integer
    add_column :groups, :speciality_code, :string
    add_column :groups, :speciality_title, :text
    add_column :groups, :subspeciality_title, :text
    add_column :groups, :chair_id, :integer
    add_column :groups, :plan_year, :integer
  end
end
