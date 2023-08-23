class Task < ApplicationRecord
  enum status: { pending: 1, in_progress: 2, completed: 3 }

  belongs_to :assignee_user, foreign_key: 'assignee_user_id', class_name: 'User'
  belongs_to :assigner_user, foreign_key: 'assigner_user_id', class_name: 'User'

  has_many :task_comments, dependent: :destroy
  has_many :task_task_categories, dependent: :destroy
  has_many :task_categories, through: :task_task_categories

  validates_presence_of :title, :description, :due_date, :priority, :status, :assignee_user_id, :assigner_user_id
end
