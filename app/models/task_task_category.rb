class TaskTaskCategory < ApplicationRecord
  belongs_to :task
  belongs_to :task_category

  validates :task_id, uniqueness: { scope: :task_category_id }
end
