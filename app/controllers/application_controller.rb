class ApplicationController < ActionController::API
  before_action :authenticate_user

  attr_accessor :current_user

  private def authenticate_user
    auth_token = request.headers['Authorization']
    user = User.find_by(auth_token: auth_token)
    if user
      self.current_user = user
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
