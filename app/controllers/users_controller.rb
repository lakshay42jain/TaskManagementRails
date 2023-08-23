class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def signup
    user = User.new(user_params)
    user.auth_token = SecureRandom.hex(32)
    if user.save
      render json: { token: user.auth_token }, status: :created
    else
      render json: { error: user.error.full_messages }, status: :unprocessable_entity
    end
  end

  def deactivate_user
    auth_token = request.headers['Authorization']
    email = params[:email]
    user_service = UserService.new
    result = user_service.deactivate_user(auth_token, email)
    if result[:status] == :ok
      render json: { message: 'User Successfully Deactivated' }, status: 200
    else
      render json: { error: result[:message] }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone_number, :name, :role, :password, :active)
  end
end
