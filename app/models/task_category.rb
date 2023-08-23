class TaskCategory < ApplicationRecord
  has_many :task_task_categories, dependent: :destroy
  has_many :tasks, through: :task_task_categories
end
