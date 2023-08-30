require 'rails_helper'

RSpec.describe TaskComment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let(:task) { Task.create(title: 'task', description: 'description', due_date: '20/12/2024', assignee_user_id: user.id, assigner_user_id: admin.id) }

  it 'belongs to a user' do
    comment = FactoryBot.create(:task_comment, user_id: user.id, task_id: task.id)
    expect(comment.user).to eq(user)
  end

  it 'belongs to a task' do
    comment = FactoryBot.create(:task_comment, task_id: task.id, user_id: user.id)
    expect(comment.task).to eq(task)
  end

  it 'validates presence of body' do
    comment = FactoryBot.build(:task_comment, body: nil)
    expect(comment).not_to be_valid
  end
end
