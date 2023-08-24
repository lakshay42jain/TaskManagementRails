class SessionsController < ApplicationController
  skip_before_action :authenticate_user 
  
  def signup
    user = User.create(user_params)
    if user.errors.blank?
      render json: { token: user.auth_token }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      if user.active == true
        render json: { message: 'Logged in successfully!', token: user.auth_token }
      else
        render json: { message: 'User Deactivated By Admin' }, status: :unauthorized
      end
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:email, :phone_number, :name, :role, :password, :active)
  end
end
