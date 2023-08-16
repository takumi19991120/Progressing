class Public::CommentsController < ApplicationController

  def create
    @song = Song.find(params[:song_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.song_id = @song.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
