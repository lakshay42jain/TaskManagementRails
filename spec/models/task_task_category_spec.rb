require 'rails_helper'

RSpec.describe TaskTaskCategory, type: :model do
  it 'belongs to a task' do
    user = FactoryBot.create(:user)
    admin = FactoryBot.create(:user, role: 0, email: 'admin@gmail.com')
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    category = FactoryBot.create(:task_category)
    task_task_category = FactoryBot.create(:task_task_category, task_id: task.id, task_category_id: category.id)
    expect(task_task_category.task).to eq(task)
  end

  it 'belongs to a task category' do
    user = FactoryBot.create(:user)
    admin = FactoryBot.create(:user, role: 0, email: 'admin@gmail.com')
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    category = FactoryBot.create(:task_category)
    task_task_category = FactoryBot.create(:task_task_category, task_id: task.id, task_category_id: category.id)
    expect(task_task_category.task_category).to eq(category)
  end

  it 'validates uniqueness of task_id within task_category' do
    user = FactoryBot.create(:user)
    admin = FactoryBot.create(:user, role: 0, email: 'admin@gmail.com')
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    category = FactoryBot.create(:task_category)
    FactoryBot.create(:task_task_category, task_id: task.id, task_category_id: category.id)
    duplicate_task_task_category = FactoryBot.build(:task_task_category, task_id: task.id, task_category_id: category.id)
    expect(duplicate_task_task_category).not_to be_valid
  end
end
