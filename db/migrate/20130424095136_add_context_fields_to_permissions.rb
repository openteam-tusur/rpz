class AddContextFieldsToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :context_id, :integer
    add_column :permissions, :context_type, :string
  end
end
