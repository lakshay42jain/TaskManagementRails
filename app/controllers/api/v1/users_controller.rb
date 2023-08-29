class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user, except: [:deactivate, :index, :tasks] 
  before_action :require_admin, only: [:deactivate, :index]

  def create
    user = User.create(user_params)
    if user.errors.blank?
      render json: { success: true, token: user.auth_token }, status: :created
    else
      render json: { success: false, error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    service = UserService.new 
    service.login(params[:email], params[:password])
    if service.errors.present? 
      render json: { success: false, errors: service.errors }, status: :unauthorized
    else 
      render json: { success: true, message: 'Logged in successfully!' }, status: :ok
    end
  end

  def deactivate
    service = UserService.new
    service.deactivate_user(params[:email])
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else
      render json: { success: true, message: 'User Deactivated Successfully' }, status: :created
    end
  end

  def index
    service = UserService.new
    users = service.find_all
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else  
      render json: { success: true, data: users.map { |user| UserSerializer.new(user) } }, each_serializer: UserSerializer, status: :ok
    end
  end

  def user_params
    params.require(:user).permit(:email, :phone_number, :name, :password, :active)
  end

  private def require_admin
    unless current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
