class Public::CommentsController < ApplicationController

  def create
    @song = Song.find(params[:song_id])
    @song_comments = @song.comments
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.song_id = @song.id
    @comment.save
  end

  def destroy
    @song = Song.find(params[:song_id])
    @song_comments = @song.comments
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
