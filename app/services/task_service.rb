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

  def delete(user, task_id)
    begin
      task = Task.find(task_id)
      task.status = 'deleted'
      task.save!
    rescue ActiveRecord::RecordNotFound => error
      self.errors = error
    end
  end
end
