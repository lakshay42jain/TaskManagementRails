class UsersController < ApplicationController
  skip_before_action :authenticate_user, except: [:deactivate_user, :all_users] 
  before_action :require_admin, only: [:deactivate_user, :all_users]

  def deactivate_user
    email = params[:email]
    result = UserService.new
    result.deactivate_user(email)
    if result.errors.present?
      render json: { error: result.errors },status: unprocessable_entity
    else
      render json: { message: "User Deactivated Successfully" }, status: :created
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

  

  def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
