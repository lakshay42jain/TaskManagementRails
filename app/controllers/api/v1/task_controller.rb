class Api::V1::TaskController < ApplicationController
  before_action :require_admin, only: [:create, :delete, :update, :find_by_category]

  def create
    service = TaskService.new
    result = service.create(current_user, task_params)
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else
      render json: { success: true, message: 'Task Assigned Successfully' }, status: :created
    end
  end

  def delete
    service = TaskService.new
    result = service.delete(params[:id])
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else
      render json: { success: true, message: 'Task Deleted Successfully' }, status: :ok
    end
  end

  def index 
    service = TaskService.new
    sort_field = params[:sort_field] || "due_date"
    tasks = service.find_all(current_user, sort_field)
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else
      render json: { success: true, data: tasks.map { |task| TaskSerializer.new(task) } }, status: :ok
    end
  end

  def update
    service = TaskService.new
    task = service.update(params[:id], task_params)
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else
      render json: { success: true, data: TaskSerializer.new(task), message: 'Task Updated Successfully' }, status: :ok
    end
  end

  def update_status
    service = TaskService.new
    task = service.update_status(current_user, params[:id], params[:status])
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else
      render json: { success: true, data: TaskSerializer.new(task), message: 'Status Updated' }, status: :ok
    end
  end

  def find_by_category
    service = TaskService.new
    tasks = service.find_by_category(params[:name])
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity 
    else
      render json: { success: true, data: tasks.map { |task| TaskSerializer.new(task) } }, status: :ok
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :assignee_user_id, :assigner_user_id, :status, :priority)
  end

  private def require_admin
    unless current_user.admin?
      render json: { success: false, error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
