class TasksTaskCategory < ApplicationRecord
  belongs_to :tasks
  belongs_to :task_category
end
