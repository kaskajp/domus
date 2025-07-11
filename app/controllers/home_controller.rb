class HomeController < ApplicationController
  before_action :require_login

  def index
    # Dashboard with overview of family coordination and property management
    @user = current_user
  end
end
