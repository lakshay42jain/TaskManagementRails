class TaskCategoryService
  attr_accessor :errors

  def find_all
    task_categories = TaskCategory.all
  end

  def create(name, description)
    task_category = TaskCategory.find_by(name: name)
    if task_category
      self.errors = 'Task Category Already Exists with this name'
    else 
      TaskCategory.create(name: name, description: description)
    end
  end

  def delete_all(name)
    task_category = TaskCategory.find_by(name: name)
    if task_category
      task_category.destroy
    else
      self.errors = 'Taskcategory not Exist With this name'
    end
  end

  def update(id, name, description)
    task_category = TaskCategory.find_by(id: id)
    if task_category
      task_category.update(name: name, description: description)
    else
      self.errors = 'Taskcategory not exist with this id'
    end
  end
end
