class TaskCategoryService
  attr_accessor :errors

  def find_all
    TaskCategory.all.to_a
  end

  def create(params)
    task_category = TaskCategory.find_by(name: params[:name])
    if task_category
      self.errors = 'Task Category Already Exists with this name'
    else 
      unless TaskCategory.create(name: params[:name], description: params[:description])
        self.errors = 'Task not created'
      end
    end
  end

  def delete_all(name)
    task_category = TaskCategory.find_by(name: name)
    if task_category
      unless task_category.destroy 
        self.errors = 'Taskcategory not deleted'
      end
    else
      self.errors = 'Taskcategory not Exist With this name'
    end
  end

  def update(id, params)
    task_category = TaskCategory.find_by(id: id)
    if task_category
      unless task_category.update(name: params[:name], description: params[:description])
        self.errors = 'Taskcategory not Updated'
      end
    else
      self.errors = 'Taskcategory not Exist With this name'
    end
  end
end
