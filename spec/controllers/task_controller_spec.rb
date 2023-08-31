require 'rails_helper'

RSpec.describe Api::V1::TaskController, type: :controller do
  let!(:user) { FactoryBot.create(:user, email: 'user@email.com') }
  let!(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }

  context 'POST Create' do 
    it 'create task if user is admin' do 
      @request.headers['Authorization'] = admin.auth_token
      params = { task: { title: 'title', description: 'description', due_date: Date.today + 7.days, assignee_user_id: user.id, assigner_user_id: admin.id } }
      post :create, params: params
      expect(response).to have_http_status(:ok)
    end

    it 'create task if user is not admin' do 
      @request.headers['Authorization'] = user.auth_token
      params = { task: { title: 'title', description: 'description', due_date: Date.today + 7.days, assignee_user_id: user.id, assigner_user_id: admin.id } }
      post :create, params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'DELETE task' do 
    it 'delete task if user is admin' do 
      @request.headers['Authorization'] = admin.auth_token
      task = FactoryBot.create(:task, assigner_user_id: admin.id)
      delete :delete, params: { id: task.id }
      expect(response).to have_http_status(:ok)
    end

    it 'delete task if user is not admin' do 
      @request.headers['Authorization'] = user.auth_token
      task = FactoryBot.create(:task, assigner_user_id: admin.id)
      delete :delete, params: { id: task.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'GET index' do 
    it 'if user is admin' do 
      @request.headers['Authorization'] = admin.auth_token
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'if user is not admin' do 
      @request.headers['Authorization'] = user.auth_token
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  context 'PUT Update' do 
    it 'update task if user is admin' do 
      task = FactoryBot.create(:task)
      @request.headers['Authorization'] = admin.auth_token
      params = { id: task.id, task: { title: 'title_updated' } }
      patch :update, params: params
      expect(response).to have_http_status(:ok)
    end

    it 'update task if user is not admin' do 
      task = FactoryBot.create(:task)
      @request.headers['Authorization'] = user.auth_token
      params = { id: task.id, task: { title: 'title_updated' } }
      patch :update, params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'POST Update Status' do 
    it 'With Valid Status Enum' do 
      task = FactoryBot.create(:task, assignee_user_id: user.id)
      @request.headers['Authorization'] = user.auth_token
      params = { id: task.id, status: 'completed' }
      post :update_status, params: params
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST Find by category' do 
    it 'if user is admin' do 
      FactoryBot.create(:task_category, name: 'Default')
      @request.headers['Authorization'] = admin.auth_token
      post :find_by_category, params: { name: 'Default' }
      expect(response).to have_http_status(:ok)
    end

    it 'if user is not admin' do 
      @request.headers['Authorization'] = user.auth_token
      post :find_by_category, params: { name: 'default' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
