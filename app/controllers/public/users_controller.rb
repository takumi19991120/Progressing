class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @songs = @user.songs.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(song_params)
      redirect_to user_path(current_user), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def check
  end
  
  private

  def user_params
    params.require(:user).permit(:name,:introduction,:image)
  end
  
end
