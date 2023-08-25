class CreateTaskTaskCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :task_task_categories do |t|
      t.references :task, null: false, foreign_key: true
      t.references :task_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
