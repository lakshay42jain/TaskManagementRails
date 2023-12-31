class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.date :due_date
      t.integer :priority
      t.integer :status
      t.references :assignee_user, null: false, foreign_key: {to_table: :users}
      t.references :assigned_user, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
