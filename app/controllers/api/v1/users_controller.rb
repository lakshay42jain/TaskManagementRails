class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user, except: [:deactivate, :index, :tasks] 
  before_action :require_admin, only: [:deactivate, :index]

  def deactivate
    email = params[:email]
    user_service = UserService.new
    user_service.deactivate_user(email)
    if user_service.errors.present?
      render json: { error: result.errors }, status: :unprocessable_entity
    else
      render json: { message: 'User Deactivated Successfully' }, status: :created
    end
  end

  def index
    user_service = UserService.new
    users = user_service.find_all
    if user_service.errors.present?
      render json: { error: user_service.errors }, status: :unprocessable_entity
    elsif users.blank?
      render json: { message: 'Users List is Empty' }, status: :ok  
    else
      render json: users, status: :ok
    end
  end

  private def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def tasks 
    service = UserService.new
    all_tasks = service.tasks(current_user)
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    elsif all_tasks.blank?
      render json: { message: 'No Pending Task' }, status: :ok 
    else
      render json: all_tasks, status: :ok
    end
  end
end
