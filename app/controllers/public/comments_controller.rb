class Public::CommentsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      flash[:notice] = "こめんとに成功しました"
      redirect_to request.referer
    else
      flash.now[:notice] = "コメントは１文字以上１００文字以下でお願いします"
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      render 'public/posts/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    if comment.destroy
      redirect_to request.referer, notice: "コメントの削除に成功しました。"
    else
      flash.now[:notice] = "コメントの削除に失敗しました。"
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      render 'public/posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
