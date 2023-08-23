class TaskCategory < ApplicationRecord
  has_many :task_task_categories, dependent: :destroy
  has_many :tasks, through: :task_task_categories

  validates_presence_of :name, :description
end
