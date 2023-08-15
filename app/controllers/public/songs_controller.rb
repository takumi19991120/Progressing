class Public::SongsController < ApplicationController

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
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
    @user = @song.user
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
