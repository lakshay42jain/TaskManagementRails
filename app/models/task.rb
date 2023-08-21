class Task < ApplicationRecord
  belongs_to :assignee_user
  belongs_to :assigned_user
end
