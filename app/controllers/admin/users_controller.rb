class Admin::UsersController < ApplicationController

  def index
    if current_user && current_user.admin?
      @users = User.page(params[:page]).per(2)
    else
      redirect_to root_path
    end
  end

end