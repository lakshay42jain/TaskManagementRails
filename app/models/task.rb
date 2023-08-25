class Task < ApplicationRecord
  before_create :assign_task_category

  enum status: { pending: 1, in_progress: 2, completed: 3 , deleted: 4}

  belongs_to :assignee_user, class_name: 'User'
  belongs_to :assigner_user, class_name: 'User'

  has_many :task_comments, dependent: :destroy
  has_many :task_task_categories, dependent: :destroy
  has_many :task_categories, through: :task_task_categories

  validate :admin_validate
  validate :status_validate, on: :create
  validate :due_date_format_and_range
  validates_presence_of :title, :description, :due_date, :priority, :status

  private def admin_validate
    unless assigner_user.admin?
      self.errors[:base] << 'Only admin can create the task'
      raise StandardError, 'Only admin can create the task'
    end
  end

  private def status_validate
    if completed?
      self.errors[:base] << 'New tasks cannot be created with status completed'
      raise StandardError, 'New tasks cannot be created with status completed'
    end
  end

  private def assign_task_category
    category = TaskCategory.find_by(name: 'Default') || TaskCategory.create_default_task_category
    self.task_categories << category
  end

  private def due_date_format_and_range
    begin
      parsed_date = Date.parse(due_date.to_s)
      valid_range = parsed_date >= Date.today
      unless valid_range
        errors.add(:due_date, "is not in a valid format or is in the past")
      end
    rescue ArgumentError, TypeError
      errors.add(:due_date, "is not a valid date")
    end
  end
end
