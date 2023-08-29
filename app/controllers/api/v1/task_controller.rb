class Api::V1::TaskController < ApplicationController
  before_action :require_admin, only: [:delete, :update, :find_by_category]

  def create
    service = TaskService.new
    result = service.create(current_user, task_params)
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Assigned Successfully' }, status: 200
    end
  end

  def delete
    service = TaskService.new
    result = service.delete(params[:id])
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Deleted Successfully' }, status: 200
    end
  end

  def index 
    service = TaskService.new
    sort_field = params[:sort_field] || "due_date"
    tasks = service.find_all(current_user, sort_field)
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    elsif tasks.blank?
      render json: { message: 'Tasks List is Empty' }, status: :ok
    else
      render json: tasks, each_serializer: TaskSerializer, status: :ok
    end
  end

  def update
    service = TaskService.new
    result = service.update(params[:id], task_params)
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Updated Successfully' }, status: 200
    end
  end

  def update_status
    service = TaskService.new
    result = service.update_status(current_user, params[:id], params[:status])
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Status Updated' }, status: 200
    end
  end

  def find_by_category
    service = TaskService.new
    tasks = service.find_by_category(params[:name])
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    elsif tasks.blank?
      render json: { message: 'No task found in this category' }, status: :ok  
    else
      render json: tasks, each_serializer: TaskSerializer, status: :ok
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
