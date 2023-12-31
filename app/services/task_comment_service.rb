class TaskCommentService
  attr_accessor :errors

  def create(params)
    task = Task.find_by(id: params[:task_id])
    current_user = params[:user]
    if task.blank?
      self.errors = "Task not exist"
      return
    end
    
    if current_user.admin? || task.assignee == current_user.id 
      task_comment = TaskComment.new(user_id: current_user.id, task_id: task.id, body: params[:body])
      unless task_comment.save
        self.errors = task_comment.errors.full_messages.join(", ")
      end
    else
      self.errors = 'You are not assignee of this Task'    
    end
  end 
end
