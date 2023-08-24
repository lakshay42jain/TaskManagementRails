class UsersController < ApplicationController
  skip_before_action :authenticate_user, except: [:deactivate_user, :all_users] 
  before_action :require_admin, only: [:deactivate_user, :all_users]

  def signup
    user = User.create(user_params)
    if user.errors.blank?
      render json: { token: user.auth_token }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def deactivate_user
    email = params[:email]
    user_service = UserService.new
    result = user_service.deactivate_user(email)
    if result[:status] == :ok
      render json: { message: 'User Successfully Deactivated' }, status: 200
    else
      render json: { error: result[:message] }, status: :unprocessable_entity
    end
  end

  def all_users
    user_service = UserService.new
    result = user_service.find_all
    render json: result
    # if result[:status] == :ok
    #   render json: { data: result }, status: 200
    # else
    #   render json: { error: result[:message] }, status: :unprocessable_entity
    # end
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone_number, :name, :role, :password, :active)
  end

  def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
