class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end 
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :is_withdrawal, :image)
  end
  
end
