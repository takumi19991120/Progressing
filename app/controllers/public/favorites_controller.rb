class Public::FavoritesController < ApplicationController

  def create
   @song_favorite = Favorite.new(user_id: current_user.id, song_id: params[:song_id])
   @song_favorite.save
   redirect_back(fallback_location: root_path)
  end

 def destroy
  @song_favorite = Favorite.find_by(user_id: current_user.id, song_id: params[:song_id])
  @song_favorite.destroy
  redirect_back(fallback_location: root_path)
 end

end
