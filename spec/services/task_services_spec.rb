require 'rails_helper'

RSpec.describe TaskService do
  it 'creates a task' do
    user = User.new(name: 'n', phone_number: '1234512343', email: 'ss@gmail.com',password: 'psss')
    user.save
    admin = User.new(name: 'n', phone_number: '1234512343', email: 's12s@gmail.com',password: 'psss', role: 0)
    admin.save
    task_params = { title: 'ss', description: 'dd', assignee_user_id: user.id, due_date: "23/08/2024"}
    task_service = TaskService.new
    expect { task_service.create(admin, task_params) }.to change(Task, :count).by(1)
  end

  it 'handles errors and sets errors attribute' do
    task_params = { title: 'Test Task', description: 'dd', assignee_user_id: 12, due_date: "23/08/2024" } 
    admin = User.new(name: 'n', phone_number: '1234512343', email: 's12s@gmail.com',password: 'psss', role: 0)
    admin.save
    task_service = TaskService.new
    task_service.create(admin, task_params)
    expect(task_service.errors).to be_an_instance_of(ActiveRecord::RecordInvalid)
  end
end
