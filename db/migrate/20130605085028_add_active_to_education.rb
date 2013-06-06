class AddActiveToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :active, :boolean, :default => true
  end
end
