class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [ :new, :create ]

  def new
    # Login form
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      if user.confirmed?
        log_in(user)
        flash[:notice] = "Welcome back, #{user.first_name}!"
        redirect_to root_path
      else
        flash.now[:alert] = "Please confirm your email address before logging in."
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash[:notice] = "You have been logged out."
    redirect_to login_path
  end

  private

  def redirect_if_logged_in
    if logged_in?
      flash[:notice] = "You are already logged in."
      redirect_to root_path
    end
  end
end
