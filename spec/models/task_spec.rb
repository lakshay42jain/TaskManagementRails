require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let(:task) { FactoryBot.create(:task, assigner_user_id: admin.id)}

  it 'assigns default category before creation' do
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    default_category = TaskCategory.find_by(name: 'Default')
    expect(task.categories).to include(default_category)
  end

  it 'cannot be created with completed status' do
    task = Task.new(assigner_user_id: admin.id, assignee_user_id: user.id, status: 4)
    expect(task).not_to be_valid
  end

  it 'task not created by normal user' do
    task = Task.new(assigner_user_id: user.id, assignee_user_id: user.id)
    expect(task).not_to be_valid
  end

  it 'validates due date format and range' do
    task = Task.new(assigner_user_id: admin.id, assignee_user_id: user.id, due_date: 'invalid_date')
    expect(task).not_to be_valid

    task.due_date = Date.yesterday
    expect(task).not_to be_valid
  end

  it 'associates with assignee and assigner users' do
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    expect(task.assignee).to eq(user)
    expect(task.assigner).to eq(admin)
  end

  it 'associates with comments' do
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    comment = FactoryBot.create(:task_comment, task_id: task.id, user_id: user.id)
    expect(task.comments).to include(comment)
  end

  it 'associates with categories through task_task_categories' do
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    category = FactoryBot.create(:task_category)
    task.categories << category
    expect(task.categories).to include(category)
  end
end
