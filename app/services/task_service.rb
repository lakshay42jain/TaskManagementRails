class TaskService
  def create(user, task_params)
    if user&.role == 'admin'
      task = Task.new(task_params)
      task.assigner_user_id = user.id 
      if task.save
        { status: :ok }
      else
        { error: task.errors.full_messages }
      end 
    else
      { message: 'Only Admin can Assign the Task' }
    end
  end
end
