class TaskCategoryService
  attr_accessor :errors

  def find_all
    task_categories = TaskCategory.all
  end
end
