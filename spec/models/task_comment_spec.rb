require 'rails_helper'

RSpec.describe TaskComment, type: :model do
  it 'belongs to a user' do
    user = FactoryBot.create(:user)
    admin = FactoryBot.create(:user, role: 0, email: 'admin@gmail.com')
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    comment = FactoryBot.create(:task_comment, user_id: user.id, task_id: task.id)
    expect(comment.user).to eq(user)
  end

  it 'belongs to a task' do
    user = FactoryBot.create(:user)
    admin = FactoryBot.create(:user, role: 0, email: 'admin@gmail.com')
    task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
    comment = FactoryBot.create(:task_comment, task_id: task.id, user_id: user.id)
    expect(comment.task).to eq(task)
  end

  it 'validates presence of body' do
    comment = FactoryBot.build(:task_comment, body: nil)
    expect(comment).not_to be_valid
  end
end
