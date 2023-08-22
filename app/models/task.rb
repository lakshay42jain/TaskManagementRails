class Task < ApplicationRecord
  enum status: {pending: 1, in_progress: 2, completed: 3}
  belongs_to :user, foreign_key: 'assignee_user_id'
  belongs_to :user, foreign_key: 'assigner_user_id'
  has_many :task_comments
  has_many :task_task_categories
  has_many :task_categories, through: :task_task_categories
end
