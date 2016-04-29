class Admin::UsersController < ApplicationController

    def index
      if current_user && current_user.admin?
        @users = User.all.page(params[:page]).per(5)
      else
        redirect_to root_path
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if @user.update_attributes(user_params)
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      UserMailer.delete_email(@user).deliver
      @user.destroy
      redirect_to admin_users_path
    end

  protected

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
    end

end