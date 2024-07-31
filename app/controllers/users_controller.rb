class UsersController < ApplicationController
  # POST /users/create
  def create
    user = User.new(user_params)
    if user.save
      Rails.logger.info "Created user with ID: #{user.id}"
      render json: { user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /users/login
  def login
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
      render json: { token: token }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  # Strong parameters for user creation
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # Strong parameters for login
  def login_params
    params.require(:user).permit(:email, :password)
  end
end
