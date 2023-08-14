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
      @song = Song.new
      render :new
    end
  end

  def index
  end

  def show
  end

  def edit
  end
  
  private

  def song_params
    params.require(:song).permit(:title,:body,:genre_id,:user_id)
  end  
  

end
