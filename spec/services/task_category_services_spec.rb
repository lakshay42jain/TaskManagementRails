require 'rails_helper'

RSpec.describe TaskCategoryService do
  let(:service) { TaskCategoryService.new }
  let!(:task_category) { FactoryBot.create(:task_category) }

  context 'find_all' do
    it 'returns a list of all task categories' do
      FactoryBot.create(:task_category, name: 'catA')
      FactoryBot.create(:task_category, name: 'catB')
      task_categories = service.find_all
      expect(task_categories.size).to eq(3)
    end
  end

  context 'when task category created' do
    it 'creates a task category' do
      params = { name: 'New Category', description: 'Category description' }
      service.create(params)
      expect(service.errors).to be_nil
    end

    it 'already exists with same name' do
      params = { name: 'name', description: 'Category description' }
      service.create(params)
      expect(service.errors).to eq('Task Category Already Exists with this name')
    end
  end

  context 'when task category Deleted' do
    it 'deletes the task category' do
      params = { name: 'Demo', description: 'Category description' }
      service.create(params)
      service.delete_all('Demo')
      expect(service.errors).to be_nil
    end

    it 'not Exists' do
      service.delete_all('NonexistentCategory')
      expect(service.errors).to eq('Taskcategory not Exist With this name')
    end
  end

  context 'when task category Updated' do
    it 'updates the task category' do
      task_category = FactoryBot.create(:task_category, name: 'Newname')
      params = { name: 'Updated Category', description: 'Updated description' }
      service.update(task_category.id, params)
      updated_category = TaskCategory.find(task_category.id)
      expect(updated_category.name).to eq(params[:name])
    end

    it 'not Exists' do
      params = { name: 'Updated Category', description: 'Updated description' }
      service.update(999, params)
      expect(service.errors).to eq('Taskcategory not Exist With this name')
    end
  end
end
