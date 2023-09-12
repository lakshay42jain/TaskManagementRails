require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let(:task) { FactoryBot.create(:task, assigner_user_id: admin.id) }

  context 'Validation presence of attributes' do
    it 'validates presence of title' do
      expect(task).to validate_presence_of(:title)
    end

    it 'validates presence of description' do
      expect(task).to validate_presence_of(:description)
    end

    it 'validates presence of due_date' do
      expect(task).to validate_presence_of(:due_date)
    end

    it 'validates presence of status' do
      expect(task).to validate_presence_of(:status)
    end

    it 'validates presence of priority' do
      expect(task).to validate_presence_of(:priority)
    end
  end

  context 'before creation validate' do 
    it 'assigns default category before creation' do
      task = FactoryBot.create(:task, assignee_user_id: user.id, assigner_user_id: admin.id)
      default_category = TaskCategory.find_by(name: 'Default')
      expect(task.categories).to include(default_category)
    end
  end

  context 'wrong attributes values' do 
    it 'cannot be created with completed status' do
      task = FactoryBot.build(:task, assignee_user_id: user.id, assigner_user_id: admin.id, status: 3)
      expect(task.save).to be_falsey
    end
  
    it 'task not created by normal user' do
      task = FactoryBot.build(:task, assignee_user_id: user.id, assigner_user_id: user.id)
      expect(task.save).to be_falsey
    end
  
    it 'validates due date format and range' do
      task = FactoryBot.build(:task, assignee_user_id: user.id, assigner_user_id: admin.id, due_date: 'invalid_date')
      expect(task.save).to be_falsey
  
      task.due_date = Date.yesterday
      expect(task.save).to be_falsey
    end
  end

  context 'Assosciations Validate' do 
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
end
