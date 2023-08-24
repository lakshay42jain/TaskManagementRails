class UsersController < ApplicationController
  skip_before_action :authenticate_user, except: [:deactivate_user, :all_users] 
  before_action :require_admin, only: [:deactivate_user, :all_users]

  def deactivate_user
    email = params[:email]
    result = UserService.new
    result.deactivate_user(email)
    if result.errors.present?
      render json: { error: result.errors }, status: unprocessable_entity
    else
      render json: { message: 'User Deactivated Successfully' }, status: :created
    end
  end

  def all_users
    result = UserService.new
    users = user_service.find_all
    if result.errors.present?
      render json: { error: result.errors }, status: unprocessable_entity
    elsif users.blank?
      render json: { message: 'Users List is Empty' }, status: :ok  
    else
      render json: result, status: :ok err
    end
  end

  private def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
