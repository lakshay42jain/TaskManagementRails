class Api::V1::TaskController < ApplicationController
  def create
    task_service = TaskService.new
    result = task_service.create(current_user, task_params)
    if task_service.errors.present?
      render json: { error: task_service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Assigned Successfully' }, status: 200
    end
  end

  def delete
    task_service = TaskService.new
    result = task_service.delete(current_user, params[:id])
    if task_service.errors.present?
      render json: { error: task_service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Deleted Successfully' }, status: 200
    end
  end

  def index 
    task_service = TaskService.new
    tasks = task_service.find_all
    if task_service.errors.present?
      render json: { error: task_service.errors }, status: :unprocessable_entity
    elsif tasks.blank?
      render json: { message: 'Tasks List is Empty' }, status: :ok  
    else
      render json: tasks, status: :ok
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :assignee_user_id, :assigner_user_id, :status, :priority)
  end

  private def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
