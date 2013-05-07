class AddGpoAlternativeToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :gpo_alternative, :boolean, :default => false
  end
end
