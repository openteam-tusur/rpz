class RemoveYearFromGroup < ActiveRecord::Migration
  def up
    remove_column :groups, :year_id
  end

  def down
    add_column :groups, :year_id, :integer
    add_index :groups, :year_id
  end

end
