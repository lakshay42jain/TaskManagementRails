require 'rails_helper'

RSpec.describe UserService do
  let(:service) { UserService.new }
  let(:active_user) { FactoryBot.create(:user) } 
  let(:inactive_user) { FactoryBot.create(:user, active: false, email: 'user1@gmail.com') }

  context 'deactivate_user' do
    it 'deactivates an active user' do
      service.deactivate_user(active_user.email)
      expect(active_user.reload.active).to be(false)
    end

    it 'returns an error if user is already deactivated' do
      service.deactivate_user(inactive_user.email)
      expect(service.errors).to eq('User already deactivated')
    end

    it 'returns an error if user is not found' do
      service.deactivate_user('non@example.com')
      expect(service.errors).to eq('User not found')
    end
  end

  context 'login' do
    it 'login active user with correct credentials' do
      service.login(active_user.email, 'password')
      expect(service.errors).to be_nil
    end

    it 'returns an error if user is deactivated' do
      service.login(inactive_user.email, 'password')
      expect(service.errors).to eq('user deactivated by admin')
    end

    it 'returns an error if credentials are invalid' do
      service.login(active_user.email, 'wrong_password')
      expect(service.errors).to eq('Invalid email and password')
    end
  end

  context 'find_all' do
    it 'returns a list of all users' do
      user_1 = FactoryBot.create(:user, email: 'user1@gmail.com')
      user_2 = FactoryBot.create(:user, email: 'user2@gmail.com')
      users = service.find_all
      expect(users).to eq([user_1, user_2])
    end
  end
end
