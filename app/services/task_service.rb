class TaskService
  attr_accessor :errors

  def create(user, task_params)
      task = Task.new(task_params)
      task.assigner_user_id = user.id 
      if task.save
        task 
      else
        self.errors = task.errors.full_messages
      end
  end
end
