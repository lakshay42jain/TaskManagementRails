class User < ApplicationRecord
  enum role: { admin: 0, normal: 1 }
  has_many :tasks, foreign_key: 'assignee_user_id'
  has_many :task_comments

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }

  has_secure_password
end
