class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.references :course
      t.string :title
      t.references :semester

      t.timestamps
    end
    add_index :streams, :course_id
    add_index :streams, :semester_id

    add_column :educations, :stream_id, :integer
    add_index :educations, :stream_id
  end
end
