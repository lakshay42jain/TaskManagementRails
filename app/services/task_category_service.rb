class TaskCategoryService
  attr_accessor :errors

  def find_all
    task_categories = TaskCategory.all
  end

  def delete_all(name)
    begin
      task_category = TaskCategory.find_by(name: name)
      task_category.destroy
    rescue ActiveRecord::RecordNotFound => error
      self.errors = error
    end
  end
end
