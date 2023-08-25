class Api::V1::TaskCategoryController < ApplicationController
  before_action :require_admin, only: [:index, :delete]

  def index 
    task_category_service = TaskCategoryService.new
    all_task_category = task_category_service.find_all
    if task_category_service.errors.present?
      render json: { error: task_category_service.errors }, status: :unprocessable_entity
    elsif all_task_category.blank?
      render json: { message: 'Task Category List is Empty' }, status: :ok  
    else
      render json: all_task_category, status: :ok
    end
  end

  def delete
    service = TaskCategoryService.new 
    service.delete_all(params[:name])
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Category Successfully Deleted' }, status: :created
    end
  end

  private def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
