class User < ApplicationRecord
  has_secure_password
  
  before_create :generate_auth_token

  enum role: { admin: 0, normal: 1 }

  has_many :tasks, foreign_key: 'assignee_user_id', dependent: :destroy
  has_many :task_comments, dependent: :destroy

  validates_presence_of :name, :password
  validates :phone_number, presence: true, length: { is: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  private
  def generate_auth_token
    self.auth_token = SecureRandom.hex(32)
  end
  
end
