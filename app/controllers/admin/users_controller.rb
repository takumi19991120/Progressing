class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @songs = @user.songs.all
    @favorites = Favorite.where(user_id: @user.id).pluck(:song_id)
    @favorite_songs = Song.find(@favorites)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @user.songs.destroy_all
    @user.comments.destroy_all
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :is_withdrawal, :image)
  end

end
