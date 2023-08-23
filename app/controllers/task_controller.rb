class TaskController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    auth_token = request.headers['Authorization']
    user = User.find_by(auth_token: auth_token)
    task_service = TaskService.new
    result = task_service.create(user, task_params)
    if result[:status] == :ok
      render json: { message: 'Task Assigned Successfully' }, status: 200
    else
      render json: result, status: :unprocessable_entity
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :assignee_user_id, :assigner_user_id, :status, :priority)
  end
end
