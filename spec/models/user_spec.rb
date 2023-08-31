require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context 'Validation presence of attributes' do
    it 'validates presence of email' do
      expect(user).to validate_presence_of(:email)
    end

    it 'validates presence of name' do
      expect(user).to validate_presence_of(:name)
    end

    it 'validates presence of phone_number' do
      expect(user).to validate_presence_of(:phone_number)
    end
  end

  it 'is valid with valid attributes' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  context 'with invalid attributes' do 
    it 'is not valid without a email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end
  
    it 'is not valid with an invalid email format' do
      user = FactoryBot.build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
    end
  
    it 'is not valid with a duplicate email' do
      existing_user = FactoryBot.create(:user)
      user = FactoryBot.build(:user, email: existing_user.email)
      expect(user).not_to be_valid
    end
  
    it 'is not valid without a phone number' do
      user = FactoryBot.build(:user, phone_number: nil)
      expect(user).not_to be_valid
    end
  
    it 'is not valid with an invalid phone number' do
      user = FactoryBot.build(:user, phone_number: '12345')
      expect(user).not_to be_valid
    end
    
    it 'is not valid without a name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
    end
  end

  it 'can have an admin role' do
    user = FactoryBot.create(:user, role: 0)
    expect(user.admin?).to be true
  end

  context 'associations validate' do 
    it 'has tasks associated' do
      user = FactoryBot.create(:user)
      admin = FactoryBot.create(:user, role: 0, email: 'admin@gmail.com')
      task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
      expect(user.tasks).to include(task)
    end
  
    it 'has task comments associated' do
      user = FactoryBot.create(:user, role: 0)
      task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: user.id)
      task_comment = FactoryBot.create(:task_comment, user_id: user.id, task_id: task.id)
      expect(user.task_comments).to include(task_comment)
    end  
  end
end
