class TaskCategory < ApplicationRecord
  has_many :task_task_categories, dependent: :destroy
  has_many :tasks, through: :task_task_categories

  validates_presence_of :name, :description

  private def self.create_default_task_category
    TaskCategory.create(name: 'Default', description: 'Default')
  end
end
