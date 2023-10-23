class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    redirect_to root_path unless current_user == @comment.user
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
