class TaskCommentService
  attr_accessor :errors

  def create(current_user, task_id, comment)
    task = Task.find_by(id: task_id)
    return self.errors = "not exist" if task.blank?
    if current_user.admin? || task.assignee == current_user.id 
      TaskComment.create(user_id: current_user.id, task_id: task.id, body: comment)
    else
      self.errors = 'You are not assignee of this Task'    
    end
  end
end
