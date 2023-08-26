class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @songs = @user.songs.all
    @favorites = Favorite.where(user_id: @user.id).pluck(:song_id)
    @favorite_songs = Song.find(@favorites)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def check
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_withdrawal: true)
    reset_session
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: @user.id).pluck(:song_id)
    @favorite_songs = Song.find(@favorites)
  end
  
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

  def user_params
    params.require(:user).permit(:name,:introduction,:image,:is_withdrawal)
  end
  
end
