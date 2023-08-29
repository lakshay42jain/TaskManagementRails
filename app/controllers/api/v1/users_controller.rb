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
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      if user.active == true
        render json: { success: true, message: 'Logged in successfully!', token: user.auth_token }
      else
        render json: { success: false, message: 'User Deactivated By Admin' }, status: :unauthorized
      end
    else
      render json: { success: false, error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def deactivate
    email = params[:email]
    service = UserService.new
    service.deactivate_user(email)
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
