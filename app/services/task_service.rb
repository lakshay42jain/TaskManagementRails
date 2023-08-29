class TaskService
  attr_accessor :errors

  def create(user, task_params)
    begin 
      task = Task.new(task_params)
      task.assigner_user_id = user.id 
      task.save!
    rescue ActiveRecord::RecordInvalid => error
      self.errors = error
    end
  end

  def delete(task_id)
    begin
      task = Task.find(task_id)
      if task.deleted?
        self.errors = 'Already deleted' 
        return 
      end
      task.deleted!
    rescue ActiveRecord::RecordNotFound => error
      self.errors = 'Task Not Exist'
    end
  end

  def find_all(current_user, sort_field)
    if current_user.admin?
      tasks = Task.all
    else    
      tasks = Task.where(assignee_user_id: current_user.id, status: [1, 2])
    end

    case sort_field 
    when "due_date"
      tasks = tasks.order(due_date: :asc)
    when "creation_date"
      tasks = tasks.order(created_at: :desc)
    when "priority"
      tasks = tasks.order(priority: :asc)
    else
      tasks = tasks.order(due_date: :asc)
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
