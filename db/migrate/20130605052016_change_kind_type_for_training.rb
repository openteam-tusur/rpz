require 'progress_bar'

class ChangeKindTypeForTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :kind_temp, :integer

    pb = ProgressBar.new(Training.count)
    puts 'Backup data'
    Training.all.each do |training|
      kind = 0
      case training.kind
      when 'lecture'
        kind = 1
      when 'practice'
        kind = 2
      when 'lab'
        kind = 3
      when 'csr'
        kind = 4
      end
      training.update_column :kind_temp, kind
      pb.increment!
    end

    remove_column :trainings, :kind
    add_column :trainings, :kind, :integer

    pb = ProgressBar.new(Training.count)
    puts 'Update data'
    Training.all.each do |training|
      training.update_column :kind, training.kind_temp
      pb.increment!
    end

    remove_column :trainings, :kind_temp
  end
end
