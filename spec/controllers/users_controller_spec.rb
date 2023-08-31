require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user, email: 'user@email.com') }
  let!(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }

  context 'POST Create' do
    it 'creates a new user' do
      params = { name: 'name', email: 'email@email.com', password: 'password', phone_number: '1234512345' }
      expect {
        post :create, params: { user: params }
      }.to change(User, :count).by(1)
    end

    it 'returns a success response with token' do
      params = { name: 'name', email: 'email@email.com', password: 'password', phone_number: '1234512345' }
      post :create, params: { user: params }
      expect(response).to have_http_status(:created)

    end

    it 'does not create a new user' do
      params = { name: 'name', password: 'password', phone_number: '1234512345' }
      expect {
        post :create, params: { user: params }
      }.to change(User, :count).by(0)
    end
  end

  context 'POST Login' do
    it 'when successfully login ' do
      params = { email: 'user@email.com', password: 'password' }
      post :login, params: params
      expect(response).to have_http_status(:ok)
    end

    it 'unauthorized login' do
      params = { email: 'user@email.com', password: 'password12' }
      post :login, params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'GET index' do
    it 'returns a list of users when user is admin' do
      FactoryBot.create(:user)
      @request.headers['Authorization'] = admin.auth_token
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'unauthorised error when user is not admin' do
      FactoryBot.create(:user)
      @request.headers['Authorization'] = user.auth_token
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
