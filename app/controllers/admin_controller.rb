class AdminController < ApplicationController

  def users
    if current_user.admin?
      #list all the users in the app
      @users = User.all
    else
      redirect_to root
    end

  end
end
