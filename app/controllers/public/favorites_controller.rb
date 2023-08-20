class Public::FavoritesController < ApplicationController

  def create
    @song = Song.find(params[:song_id])
    favorite = current_user.favorites.new(song_id: @song.id)
    favorite.save
  end

  def destroy
    @song = Song.find(params[:song_id])
    favorite = current_user.favorites.find_by(song_id: @song.id)
    favorite.destroy
  end

end
