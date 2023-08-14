class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @songs = @user.songs.all
  end

  def edit
  end

  def check
  end
  
  private

  def user_params
    params.require(:user).permit(:name,:introduction,:image)
  end
  
end
