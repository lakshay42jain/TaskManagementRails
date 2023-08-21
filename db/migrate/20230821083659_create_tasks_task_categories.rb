class CreateTasksTaskCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks_task_categories do |t|
      t.references :tasks, null: false, foreign_key: true
      t.references :task_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
