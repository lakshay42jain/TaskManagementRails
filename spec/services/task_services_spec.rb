require 'rails_helper'

RSpec.describe TaskService do
  let(:service) { TaskService.new }
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, role: 0, email: 'admin@gmail.com') }
  let!(:task_1) { FactoryBot.create(:task, title: 'task1', assignee_user_id: user.id, assigner_user_id: admin.id) }
  let!(:task_2) { FactoryBot.create(:task, title: 'task2', assignee_user_id: user.id, assigner_user_id: admin.id) }
  let(:category) { FactoryBot.create(:task_category) }

  context 'for creating a task' do
    it 'creates a task with valid attributes' do
      task_params = { title: 'task_demo', description: 'dd', assignee_user_id: user.id, due_date: "23/08/2024" }
      expect { service.create(admin, task_params) }.to change(Task, :count).by(1)
    end

    it 'handles errors and sets errors attribute' do
      task_params = { title: 'Test Task', description: 'dd', assignee_user_id: 12, due_date: "23/08/2024" } 
      service.create(admin, task_params)
      expect(service.errors).to be_an_instance_of(ActiveRecord::RecordInvalid)
    end
  end

  context 'for deleting a task' do
    it 'marks a task as deleted' do
      service.delete(task_1.id)
      expect(task_1.reload).to be_deleted
    end

    it 'sets errors if task is not found' do
      service.delete(999)
      expect(service.errors).to eq('Task Not Exist')
    end
  end

  context 'for updating a task' do
    it 'updates the task with valid parameters' do
      new_task_params = { title: 'Updated Title' }
      service.update(task_1.id, new_task_params)
      expect(task_1.reload.title).to eq('Updated Title')
    end

    it 'sets errors if task is not found' do
      service.update(999, { title: 'New Title' })
      expect(service.errors).to eq('Task not found')
    end
  end

  context 'for updating the task status' do
    it 'updates the task status' do
      new_status = 'completed'
      service.update_status(user, task_1.id, new_status)
      expect(task_1.reload.status).to eq(new_status)
    end

    it 'sets errors' do
      service.update_status(user, 999, 'in_progress')
      expect(service.errors).to eq('Task not found')
    end
  end

  context 'list all tasks' do
    it 'returns all tasks when user is admin' do
      tasks = service.find_all(admin, 'priority')
      expect(tasks).to eq([task_1, task_2])
    end

    it 'returns all tasks when user is not admin' do
      tasks = service.find_all(user, 'due_date')
      expect(tasks).to eq([task_1, task_2])
    end
  end

  context 'when a task category exists' do
    it 'returns tasks associated with the specified category' do
      category = FactoryBot.create(:task_category, name: 'name')
      FactoryBot.create(:task_task_category, task_id: task_1.id, task_category_id: category.id)
      tasks = service.find_by_category('name')
      expect(tasks).to eq([task_1])
    end
  end
end
