class Admin::SongsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Song.ransack(params[:q])
    @songs = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end

  def show
    @song = Song.find(params[:id])
    @user = @song.user
    @comment = Comment.new
    @song_comments = @song.comments
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
