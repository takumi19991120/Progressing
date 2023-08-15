class Admin::SongsController < ApplicationController
  def index
    @songs = Song.all.page(params[:page]).per(10)
  end

  def show
    @song = Song.find(params[:id])
  end
  
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to admin_songs_path
  end
  
  private

  def song_params
    params.require(:song).permit(:title, :body, :genre_id, :user_id)
  end
  
end
