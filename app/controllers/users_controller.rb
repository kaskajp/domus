class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [ :new, :create ]
  before_action :require_login, only: [ :show, :edit, :update ]
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :require_user_or_admin, only: [ :show, :edit, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Auto-confirm first user as admin
      if User.count == 1
        @user.update!(role: "admin", confirmed_at: Time.current)
      end

      log_in(@user)
      flash[:notice] = "Welcome to Domus, #{@user.first_name}!"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # User profile page
  end

  def edit
    # Edit user form
  end

  def update
    update_params = user_params

    # Remove password params if they're blank (user doesn't want to change password)
    if update_params[:password].blank?
      update_params = update_params.except(:password, :password_confirmation)
    end

    if @user.update(update_params)
      flash[:notice] = "Your profile has been updated."
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

  def redirect_if_logged_in
    if logged_in?
      flash[:notice] = "You are already logged in."
      redirect_to root_path
    end
  end

  def require_user_or_admin
    unless current_user == @user || current_user.admin?
      flash[:alert] = "You don't have permission to access this page."
      redirect_to root_path
    end
  end
end
