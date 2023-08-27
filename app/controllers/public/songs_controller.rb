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
      redirect_to user_path(current_user), notice: "投稿に成功しました"
    else
      @genres = Genre.all
      @songs = Song.all
      @song = Song.new
      flash.now[:alert] = '曲名か投稿内容が空欄のため投稿に失敗しました'
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
      redirect_to song_path(@song), notice: "投稿内容を更新しました"
    else
      @genres = Genre.all
      flash.now[:alert] = '曲名か投稿内容が空欄のため更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to user_path(current_user), notice: "投稿を削除しました"
  end


  private

  def song_params
    params.require(:song).permit(:title,:body,:genre_id,:user_id)
  end


end
