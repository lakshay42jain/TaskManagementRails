require 'rails_helper'

RSpec.describe Api::V1::TaskCategoryController, type: :controller do
  let!(:user) { FactoryBot.create(:user, email: 'user@email.com') }
  let!(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let(:category) { FactoryBot.create(:task_category) }

  context 'GET Index' do
    it 'list all task category if user is admin' do 
      @request.headers['Authorization'] = admin.auth_token
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  context 'DELETE Category' do 
    it 'delete category if user is admin' do 
      FactoryBot.create(:task_category, name: 'dummy_cat')
      @request.headers['Authorization'] = admin.auth_token
      delete :delete, params: { name: 'dummy_cat' }
      expect(response).to have_http_status(:ok)
    end

    it 'delete category if user is not admin' do 
      FactoryBot.create(:task_category, name: 'dummy_cat')
      @request.headers['Authorization'] = user.auth_token
      delete :delete, params: { name: 'dummy_cat' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'PUT Update' do
    it 'update task category if user is admin' do
      @request.headers['Authorization'] = admin.auth_token
      valid_params = { id: category.id, task_category: { name: 'Updated Category', description: 'Updated Desc' } }
      patch :update, params: valid_params
      expect(response).to have_http_status(:ok)
      category.reload
      expect(category.name).to eq('Updated Category')
    end

    it 'update task category if user is not admin' do
      @request.headers['Authorization'] = user.auth_token
      valid_params = { id: category.id, task_category: { name: 'Updated Category', description: 'Updated Desc' } }
      patch :update, params: valid_params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'POST Create' do
    it 'create task category if user is admin' do
      @request.headers['Authorization'] = admin.auth_token
      valid_params = { task_category: { name: 'New Category', description: 'New Desc' } }
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
    end

    it 'create task category if user is not admin' do
      @request.headers['Authorization'] = user.auth_token
      valid_params = { task_category: { name: 'New Category', description: 'New Desc' } }
      post :create, params: valid_params
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
