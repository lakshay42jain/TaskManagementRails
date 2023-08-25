class CreateTaskComments < ActiveRecord::Migration[7.0]
  def change
    create_table :task_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
