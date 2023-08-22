class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { message: 'Logged in successfully!', token: user.auth_token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    auth_token = request.headers['Authorization']
    user = User.find_by(auth_token: auth_token)
    if user
      user.update(auth_token: nil)
      render json: { message: 'Logged out' }
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
