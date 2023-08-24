class TaskController < ApplicationController
  def create
    task_service = TaskService.new
    result = task_service.create(current_user, task_params)
    if result.errors.present?
      render json: { error: result.errors }, status: unprocessable_entity
    else
      render json: { message: 'Task Assigned Successfully' }, status: 200
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :assignee_user_id, :assigner_user_id, :status, :priority)
  end
end
