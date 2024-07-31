class ApplicationController < ActionController::API
  def authenticate_user!
    token = request.headers['Authorization'].split(' ').last
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    @current_user = User.find(decoded['user_id'])
  rescue
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end

  def current_user
    @current_user
  end
end
