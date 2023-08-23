class TaskTaskCategory < ApplicationRecord
  belongs_to :task
  belongs_to :task_category
end
