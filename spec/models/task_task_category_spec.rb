require 'rails_helper'

RSpec.describe TaskTaskCategory, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let(:category) { FactoryBot.create(:task_category) }
  let(:task) { Task.create(title: 'task', description: 'description', due_date: '20/12/2024', assignee_user_id: user.id, assigner_user_id: admin.id) }

  it 'belongs to a task' do
    task_task_category = FactoryBot.create(:task_task_category, task_id: task.id, task_category_id: category.id)
    expect(task_task_category.task).to eq(task)
  end

  it 'belongs to a task category' do
    task_task_category = FactoryBot.create(:task_task_category, task_id: task.id, task_category_id: category.id)
    expect(task_task_category.task_category).to eq(category)
  end

  it 'validates uniqueness of task_id within task_category' do
    FactoryBot.create(:task_task_category, task_id: task.id, task_category_id: category.id)
    duplicate_task_task_category = FactoryBot.build(:task_task_category, task_id: task.id, task_category_id: category.id)
    expect(duplicate_task_task_category).not_to be_valid
  end
end
