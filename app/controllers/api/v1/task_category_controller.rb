class Api::V1::TaskCategoryController < ApplicationController
  before_action :require_admin, only: [:delete, :update, :create]

  def index 
    service = TaskCategoryService.new
    list_all = service.find_all
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    elsif list_all.blank?
      render json: { message: 'Task Category List is Empty' }, status: :ok  
    else
      render json: list_all, each_serializer: TaskCategorySerializer, status: :ok
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

  def update
    service = TaskCategoryService.new
    service.update(params[:id], category_params)
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Category Successfully Updated' }, status: :created
    end
  end

  def create 
    service = TaskCategoryService.new 
    service.create(category_params)
    if service.errors.present? 
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Task Category Successfully Created' }, status: :created
    end
  end

  private def category_params
    params.require(:task_category).permit(:name, :description)
  end

  private def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
