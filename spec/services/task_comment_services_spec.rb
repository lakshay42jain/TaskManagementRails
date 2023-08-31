require 'rails_helper'

RSpec.describe TaskCommentService do
  let(:service) { TaskCommentService.new }
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let!(:task) { FactoryBot.create(:task, title: 'task', assignee_user_id: user.id, assigner_user_id: admin.id) }

  context 'when task exists' do
    it 'creates a task comment by an admin user' do
      params = { task_id: task.id, user: admin, body: 'Comment body' }
      service.create(params)
      expect(service.errors).to be_nil
    end

    it 'returns an error for a non-valid user' do
      other = FactoryBot.create(:user, email: 'other@gmail.com')
      params = { task_id: task.id, user: other, body: 'Comment body' }
      service.create(params)
      expect(service.errors).to eq('You are not assignee of this Task')
    end
  end

  context 'when task does not exist' do
    it 'returns an error' do
      params = { task_id: 999, user: user, body: 'Comment body' }
      service.create(params)
      expect(service.errors).to eq('Task not exist')
    end
  end
end
