class Task < ApplicationRecord
  before_create :assign_task_category

  enum status: { pending: 1, in_progress: 2, completed: 3 , deleted: 4 }

  belongs_to :assignee, class_name: 'User', foreign_key: :assignee_user_id
  belongs_to :assigner, class_name: 'User', foreign_key: :assigner_user_id

  has_many :comments, dependent: :destroy, class_name: 'TaskComment'
  has_many :task_task_categories, dependent: :destroy
  has_many :categories, through: :task_task_categories, source: :task_category

  validate :admin_validate, on: :create
  validate :status_validate, on: :create
  validate :due_date_format_and_range
  validates_presence_of :title, :description, :due_date, :priority, :status

  private def admin_validate
    unless assigner.admin?
      self.errors.add(:base, 'Only admin can create the task')
    end
  end

  private def status_validate
    if completed?
      self.errors.add(:base, 'New tasks cannot be created with status completed')
    end
  end

  private def assign_task_category
    category = TaskCategory.find_by(name: 'Default') || TaskCategory.create_default_task_category
    self.categories << category
  end

  private def due_date_format_and_range
    begin
      puts due_date 
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
