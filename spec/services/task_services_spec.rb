require 'rails_helper'

RSpec.describe TaskService do
  let(:user) { User.create(name: 'user', phone_number: '1234512343', email: 'ss@gmail.com',password: 'psss') }
  let(:admin) { User.create(name: 'admin_user', phone_number: '1234512343', email: 's12s@gmail.com',password: 'psss', role: 0) }
  let(:task) { Task.create(title: 'task', description: 'description', due_date: '20/12/2024', assignee_user_id: user.id, assigner_user_id: admin.id) }

  it 'creates a task' do
    task_params = { title: 'task_demo', description: 'dd', assignee_user_id: user.id, due_date: "23/08/2024" }
    task_service = TaskService.new
    expect { task_service.create(admin, task_params) }.to change(Task, :count).by(1)
  end

  it 'handles errors and sets errors attribute' do
    task_params = { title: 'Test Task', description: 'dd', assignee_user_id: 12, due_date: "23/08/2024" } 
    task_service = TaskService.new
    task_service.create(admin, task_params)
    expect(task_service.errors).to be_an_instance_of(ActiveRecord::RecordInvalid)
  end

  it 'marks a task as deleted if not deleted already' do
    task_demo = Task.create(title: 'task', description: 'description', due_date: '20/12/2024', assignee_user_id: user.id, assigner_user_id: admin.id)
    task_service = TaskService.new
    task_service.delete(task_demo.id)
    expect(task_demo.reload).to be_deleted
  end

  it 'sets errors if task is not found' do
    task_service = TaskService.new
    task_service.delete(999)
    expect(task_service.errors).to eq('Task Not Exist')
  end

  it 'updates the task with valid parameters' do
    new_task_params = { title: 'Updated Title' }
    task_service = TaskService.new
    task_service.update(task.id, new_task_params)
    expect(task.reload.title).to eq('Updated Title')
  end

  it 'sets errors' do
    task_service = TaskService.new
    task_service.update(999, { title: 'New Title' })
    expect(task_service.errors).to eq('Task not found')
  end
end
