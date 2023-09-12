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
    task = Task.find_by(id: task_id)
    if task && task.deleted?
      self.errors = 'Already deleted' 
    elsif task
      unless task.deleted!
        self.errors = 'Task not deleted'
      end
    else
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
    tasks.to_a
  end

  def update(id, task_params)
    task = Task.find_by(id: id)
    if task
      unless task.update(task_params)
        self.errors = task.errors.full_messages.join(", ")
      end
    else 
      self.errors = 'Task not found'
    end 
    task if self.errors.blank?
  end

  def update_status(current_user, id, new_status)
    task = current_user.tasks.find_by(id: id)
    if task
      unless task.update(status: new_status)
        self.errors = task.errors.full_messages.join(", ")
      end
    else
      self.errors = 'Task not found'
    end
    task if self.errors.blank?
  end

  def find_by_category(name)
    task_category = TaskCategory.find_by(name: name)
    if task_category
      task_category.tasks.to_a
    else
      self.errors = 'No task catgory exists with this name'
    end
  end
end
