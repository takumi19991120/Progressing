class Public::SongsController < ApplicationController
  before_action :authenticate_user!

  def new
    @song = Song.new
    @genres = Genre.all
  end

  def create
    @song = Song.new(song_params)
    @song.user_id = current_user.id
    if @song.save
      redirect_to user_path(current_user), notice: "You have created book successfully."
    else
      @songs = Song.all
      @song = Song.new
      render :new
    end
  end

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

  def edit
    @song = Song.find(params[:id])
    @genres = Genre.all
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      redirect_to song_path(@song), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to user_path(current_user)
  end


  private

  def song_params
    params.require(:song).permit(:title,:body,:genre_id,:user_id)
  end


end
