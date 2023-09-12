require 'rails_helper'

RSpec.describe Api::V1::TaskCommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }

    context 'POST Create' do
      it 'creates a new comment' do
        task = FactoryBot.create(:task, assignee_user_id: user.id)
        @request.headers['Authorization'] = admin.auth_token
        post :create, params: { task_comment: { task_id: task.id, body: 'Test comment' } }
        expect(response).to have_http_status(:created)
      end

      it 'when other user adding a comment' do
        task = FactoryBot.create(:task)
        @request.headers['Authorization'] = user.auth_token
        post :create, params: { task_comment: { task_id: task.id, body: 'Test comment' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
end
