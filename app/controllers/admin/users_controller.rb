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
    
    # def create
    #   # @user = User.new(user_params)

    #   # if @user.save
    #   #   admin_user_path(@user), notice: "#{@user.full_name} was edited successfully!"
    #   # else
    #   #   render :new
    #   # end
    # end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if @user.update_attributes(user_params)
        redirect_to admin_user_path(@user)
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path
    end

  protected

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
    end

  def destroy
    @user = User.find(params[:id])
    UserMailer.welcome_email(@user).deliver
    @user.destroy
    direct_to 
  end

end