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
      category = TaskCategory.new(name: params[:name], description: params[:description])
      unless category.save
        self.errors = category.errors.full_messages.join(", ")
      end
    end
  end

  def delete_all(name)
    task_category = TaskCategory.find_by(name: name)
    if task_category
      unless task_category.destroy 
        self.errors = task_category.errors.full_messages.join(", ")
      end
    else
      self.errors = 'Taskcategory not Exist With this name'
    end
  end

  def update(id, params)
    task_category = TaskCategory.find_by(id: id)
    if task_category
      unless task_category.update(name: params[:name], description: params[:description])
        self.errors = task_category.errors.full_messages.join(", ")
      end
    else
      self.errors = 'Taskcategory not Exist With this name'
    end
    task_category if self.errors.blank?
  end
end
