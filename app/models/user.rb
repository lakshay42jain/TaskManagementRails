class User < ApplicationRecord
  enum role: { admin: 0, normal: 1 }

  has_many :tasks, foreign_key: 'assignee_user_id', dependent: :destroy
  has_many :task_comments, dependent: :destroy

  validates_presence_of :phone_number, :name, :password
  validates :email, presence: true, uniqueness: true
  validates :active, inclusion: { in: [true, false] }
end
