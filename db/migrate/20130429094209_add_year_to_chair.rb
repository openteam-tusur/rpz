class AddYearToChair < ActiveRecord::Migration
  def change
    add_column :chairs, :year_id, :integer
    add_index :chairs, :year_id
  end
end
