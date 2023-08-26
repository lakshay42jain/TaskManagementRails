class TaskService
  attr_accessor :errors

  def create(user, task_params)
    begin 
      task = Task.new(task_params)
      task.assigner_user_id = user.id 
      task.save!
    rescue StandardError => error
      self.errors = error
    end
  end

  def delete(task_id)
    begin
      task = Task.find(task_id)
      return self.errors = 'Already deleted' if task.deleted?
      task.status = 'deleted'
      task.save!
    rescue ActiveRecord::RecordNotFound => error
      self.errors = error
    end
  end

  def find_all
    tasks = Task.all 
  end

  def show_all_by_sort(field)
    case field
    when "due_date"
      tasks = Task.order(due_date: :asc)
    when "creation_date"
      tasks = Task.order(created_at: :desc)
    when "priority"
      tasks = Task.order(priority: :asc)
    else
      tasks = Task.order(due_date: :asc)
    end
  end

  def update(id, task_params)
    begin
      task = Task.find(id)
      task.update(task_params)
    rescue ActiveRecord::RecordNotFound => error
      self.errors = error
    end
  end

  def update_status(current_user, id, new_status)
    task = current_user.tasks.find_by(id: id)
    if task
      task.update(status: new_status)
    else
      self.errors = 'Task not found'
    end
  end

  def find_by_category(name)
    task_category = TaskCategory.find_by(name: name)
    if task_category
      tasks = task_category.tasks
    else
      self.errors = 'No task catgory exists with this name'
    end
  end
end
