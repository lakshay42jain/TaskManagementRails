require 'rails_helper'

RSpec.describe TaskCategory, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let(:task) { Task.create(title: 'task', description: 'description', due_date: '20/12/2024', assignee_user_id: user.id, assigner_user_id: admin.id) }

  it 'has many tasks through task_task_categories' do
    category = FactoryBot.create(:task_category)
    task.categories << category
    expect(category.tasks).to include(task)
  end

  it 'validates uniqueness of name (case-insensitive)' do
    existing_category = FactoryBot.create(:task_category, name: 'Default')
    new_category = FactoryBot.build(:task_category, name: 'default')
    expect(new_category).not_to be_valid
  end

  it 'validates presence of description' do
    category = FactoryBot.build(:task_category, description: nil)
    expect(category).not_to be_valid
  end

  it 'creates a default task category' do
    default_category = TaskCategory.create_default_task_category
    expect(default_category.name).to eq('Default')
    expect(default_category.description).to eq('Default')
  end
end