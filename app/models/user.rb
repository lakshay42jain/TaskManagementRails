class User < ApplicationRecord
  enum role: {admin: 0, normal: 1}
  has_many :tasks, foreign_key: 'assignee_user_id'
  has_many :task_comments
end
