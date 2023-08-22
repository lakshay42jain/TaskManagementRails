class UpdateDefaultValuesForTasks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tasks, :priority, from: nil, to: 1
    change_column_default :tasks, :status, from: nil, to: 1
  end
end
