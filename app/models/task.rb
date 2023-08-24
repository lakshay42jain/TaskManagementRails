class Task < ApplicationRecord
  before_create :assign_task_category

  enum status: { pending: 1, in_progress: 2, completed: 3 }

  belongs_to :assignee_user, class_name: 'User'
  belongs_to :assigner_user, class_name: 'User'

  has_many :task_comments, dependent: :destroy
  has_many :task_task_categories, dependent: :destroy
  has_many :task_categories, through: :task_task_categories

  validate :admin_validate
  validate :status_validate, on: :create
  validates_presence_of :title, :description, :due_date, :priority, :status

  private def admin_validate
    unless assigner_user.admin?
      self.errors[:base] << "Only admin can create the task"
      throw(abort)
    end
  end

  private def status_validate
    if completed?
      self.errors[:base] << "New tasks cannot be created with status completed"
      throw(abort)
    end
  end

  private def assign_task_category
    self.task_categories << TaskCategory.find(1)
  end
end
